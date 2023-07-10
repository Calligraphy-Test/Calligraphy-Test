import { useBackend } from '../backend';
import { Window } from '../layouts';
import { Button, Box, Stack } from '../components';
import { Component } from 'inferno';
// offset for title bar, padding, etc
const xOffset = -5;
const yOffset = -35;

export class KanjiRecognizer extends Component {
  constructor() {
    super();
    this.state = {
      stroke: [[], [], []],
      strokes: [],
      timerStart: 0,
      res: {},
      submitCooldown: false,
    };
    this.handleMouseDown = this.handleMouseDown.bind(this);
    this.handleRightClick = this.handleRightClick.bind(this);
    this.handleMouseUp = this.handleMouseUp.bind(this);
    this.handleMouseDrag = this.handleMouseDrag.bind(this);
    this.handleRightClick = this.handleRightClick.bind(this);
    this.callApi = this.callApi.bind(this);
  }

  handleMouseDown(event) {
    if (event.button !== 0) return; // button 0 is left click, 1 is mmb, 2 right, 3 & 4 are side buttons
    const { stroke, strokes } = this.state;
    this.setState({ timerStart: Date.now() });
    strokes.push(stroke); // we add stroke here since its arrays are reference types and it'll update the UI as you draw
    this.handleMouseDrag(event);
  }

  handleMouseUp(event) {
    const { strokes } = this.state;
    this.setState({ stroke: [[], [], []], strokes: strokes, timerStart: 0 });
  }

  handleMouseDrag(event) {
    const { stroke, timerStart } = this.state;
    if (!event.clientX || !event.clientY) return;
    if (timerStart === 0) return;
    stroke[0].push(event.clientX + xOffset);
    stroke[1].push(event.clientY + yOffset);
    stroke[2].push(Date.now() - timerStart);
    this.forceUpdate();
  }

  handleRightClick(event) {
    const { strokes } = this.state;
    event.preventDefault(); // stops context menu from popping up
    strokes.pop();
    this.forceUpdate();
  }

  callApi() {
    const { strokes } = this.state;
    this.setState({ submitCooldown: true });
    setTimeout(() => this.setState({ submitCooldown: false }), 5000);
    // There is no documentation for the api despite being hosted by google?
    const data = {
      app_version: 0.4,
      api_level: '537.36',
      device:
        '5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36',
      input_type: 0,
      options: 'enable_pre_space',
      requests: [
        {
          writing_guide: {
            writing_area_width: window.innerWidth,
            writing_area_height: window.innerHeight,
          },
          pre_context: '',
          max_num_results: 1, // I havent noticed this parameter actually changing anything
          max_completions: 4, // This one neither
          language: 'ja',
          ink: strokes,
        },
      ],
    };
    fetch(
      'https://inputtools.google.com/request?itc=ja-t-i0-handwrit&app=translate',
      {
        method: 'POST',
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: JSON.stringify(data),
      }
    )
      .then((resp) => {
        return resp.json();
      })
      .then((respJSON) => this.setState({ res: respJSON }));
  }

  render() {
    const { act, data } = useBackend(this.context);
    const { strokes, submitCooldown, res } = this.state;
    const { theme, strokeColor, quickKanji } = data;
    let recommendedKanji = [];
    if (quickKanji) {
      recommendedKanji = Array.isArray(quickKanji) ? quickKanji : [quickKanji];
    }

    if (res && res[0] === 'SUCCESS') {
      recommendedKanji = res[1][0][1]; // yeah everything sent/recieved to them is an array );
    }
    return (
      <Window theme={theme ? theme : 'abductor'} width={500} height={500}>
        <Window.Content>
          <Stack vertical fill>
            <Stack.Item grow>
              <Box
                padding="0px"
                border="0px"
                margin="0px"
                onMouseDown={this.handleMouseDown}
                onMouseMove={this.handleMouseDrag}
                onContextMenu={this.handleRightClick}
                onMouseUp={this.handleMouseUp}
                textAlign="center">
                <svg
                  width="100%"
                  height="100%"
                  style={{
                    'position': 'absolute', // used for svg commands relative or not to the last command
                  }}>
                  {strokes.map((stroke, index) => {
                    // PATH IS A LINE FOR THE STROKE
                    let path = `M ${stroke[0][0]} ${stroke[1][0]},`; // x and y of start
                    for (let i = 0; i < stroke[0].length; i++) {
                      path += `L ${stroke[0][i]} ${stroke[1][i]}`;
                    }
                    return (
                      <path
                        key={index}
                        d={path}
                        fill="transparent"
                        stroke-width="2px"
                        stroke={strokeColor ? strokeColor : 'white'}
                      />
                    );
                  })}
                </svg>
              </Box>
            </Stack.Item>
            <Stack.Item>
              <Button
                textAlign="center"
                justify-content="center"
                content={'Submit'}
                disabled={submitCooldown}
                onClick={() => this.callApi()}
              />
            </Stack.Item>
            <Stack.Item>
              <Stack>
                {recommendedKanji.map((kanji, index) => {
                  return (
                    <Stack.Item key={index}>
                      <Button
                        content={kanji}
                        onClick={() => act('foundKanji', { kanji: kanji })}
                      />
                    </Stack.Item>
                  );
                })}
              </Stack>
            </Stack.Item>
          </Stack>
        </Window.Content>
      </Window>
    );
  }
}
