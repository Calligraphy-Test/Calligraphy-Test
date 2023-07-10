import { useBackend } from '../backend';
import { Window } from '../layouts';
import { Button, Box, Stack, LabeledList, Section, Flex } from '../components';
import { Component } from 'inferno';

export class KanjiPreview extends Component {
  constructor() {
    super();
    this.state = {
      currentKanji: '火',
      currentFilter: null,
    };
    this.render = this.render.bind(this);
  }

  render() {
    const { data } = useBackend(this.context);
    const { currentKanji, currentFilter } = this.state;
    const { kanjiList, allFilters, theme } = data;
    return (
      <Window theme={theme ? theme : 'paper'} width={350} height={450}>
        <Window.Content>
          <Stack vertical fill>
            <Stack.Item>
              <Section>
                <Stack>
                  <Stack.Item>
                    <Box fontSize="36px">{currentKanji}</Box>
                  </Stack.Item>
                  <Stack.Divider />
                  <Stack.Item>
                    <LabeledList>
                      <LabeledList.Item label="Name">
                        {kanjiList[currentKanji]['name']}
                      </LabeledList.Item>
                      <LabeledList.Item label="Description">
                        {kanjiList[currentKanji]['desc']}
                      </LabeledList.Item>
                    </LabeledList>
                  </Stack.Item>
                </Stack>
              </Section>
            </Stack.Item>
            <Stack.Item>
              <Stack>
                {allFilters.map((filter, index) => {
                  let isSelected = currentFilter === filter;
                  return (
                    <Stack.Item key={index}>
                      <Button
                        content={filter}
                        selected={isSelected}
                        onClick={() =>
                          this.setState({
                            currentFilter: isSelected ? null : filter,
                          })
                        }
                      />
                    </Stack.Item>
                  );
                })}
              </Stack>
            </Stack.Item>
            <Stack.Item grow>
              <Flex wrap>
                {Object.keys(kanjiList).map((kanji, index) => {
                  if (
                    !currentFilter ||
                    kanjiList[kanji]['filters'].indexOf(currentFilter) >= 0
                  )
                    return (
                      <Flex.Item key={index}>
                        <Button
                          content={kanji}
                          selected={currentKanji === kanji}
                          onClick={() => this.setState({ currentKanji: kanji })}
                          fontSize="18px"
                        />
                      </Flex.Item>
                    );
                })}
              </Flex>
            </Stack.Item>
          </Stack>
        </Window.Content>
      </Window>
    );
  }
}
