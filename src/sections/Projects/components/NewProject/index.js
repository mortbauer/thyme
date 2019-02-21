// @flow

import React, { useState, useCallback } from 'react';

import Button from 'semantic-ui-react/dist/commonjs/elements/Button';
import Input from 'semantic-ui-react/dist/commonjs/elements/Input';
import Form from 'semantic-ui-react/dist/commonjs/collections/Form';

import { valueFromEventTarget } from 'core/dom';
import { useDispatch } from 'core/useRedux';

import { useResponsive } from 'components/Responsive';

import ProjectInput from '../ProjectInput';
import ProjectColourPicker from '../ProjectColourPicker';

import { addProject } from '../../actions';

function defaultState() {
  return {
    name: '',
    parent: null,
  };
}

function useNewProjectState(defaultProject = defaultState()) {
  const [name, setName] = useState<string>(defaultProject.name);
  const [parent, setParent] = useState<string | null>(defaultProject.parent);

  function resetState() {
    setName(defaultProject.name);
    setParent(defaultProject.parent);
  }

  return [name, parent, setName, setParent, resetState];
}

function NewProject() {
  const [name, parent, setName, setParent, resetState] = useNewProjectState();
  const [showLabels] = useResponsive({ max: 'tablet' });
  const onAddProject = useDispatch(dispatch => project => dispatch(addProject({ ...project })));

  const onSubmit = useCallback(() => {
    if (name.trim() === '') {
      return;
    }

    onAddProject({
      name,
      parent,
    });

    resetState();
  }, [name, parent, onAddProject, resetState]);

  const onNameChange = useCallback(
    (e: Event) => setName(valueFromEventTarget(e.target)),
    [setName],
  );

  const onProjectChange = useCallback(
    (value: string | null) => setParent(value),
    [setParent],
  );

  return (
    <div className="NewProject">
      <Form onSubmit={onSubmit}>
        <Form.Group widths="equal">
          <Form.Field width={2}>
            {showLabels && (
              <label htmlFor="project-colour">
                Colour
              </label>
            )}
            <ProjectColourPicker />
          </Form.Field>
          <Form.Field>
            {showLabels && (
              <label htmlFor="project-name">
                Project name
              </label>
            )}
            <Input
              id="project-name"
              name="project-name"
              className="NewProject__input"
              type="text"
              placeholder="Project name"
              value={name}
              onChange={onNameChange}
              style={{ marginRight: 12 }}
            />
          </Form.Field>
          <Form.Field>
            {showLabels && (
              <label>
                Parent project
              </label>
            )}
            <ProjectInput
              placeholder="Select parent..."
              handleChange={onProjectChange}
              value={parent}
            />
          </Form.Field>
          <Form.Field width={8}>
            <Button
              icon="add"
              color="blue"
              fluid
              type="submit"
              content="Add project"
            />
          </Form.Field>
        </Form.Group>
      </Form>
    </div>
  );
}

export default NewProject;
