/*
 * Copyright (C) 2026 Fluxer Contributors
 *
 * This file is part of Fluxer.
 *
 * Fluxer is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Affero General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * Fluxer is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU Affero General Public License for more details.
 *
 * You should have received a copy of the GNU Affero General Public License
 * along with Fluxer. If not, see <https://www.gnu.org/licenses/>.
 */

import { Trans, useLingui } from '@lingui/react/macro';
import { observer } from 'mobx-react-lite';
import React from 'react';
import * as ModalActionCreators from '~/actions/ModalActionCreators';
import { modal } from '~/actions/ModalActionCreators';
import { FluxerTagChangeModal } from '~/components/modals/FluxerTagChangeModal';
import { Button } from '~/components/uikit/Button/Button';
import styles from './UsernameSection.module.css';

interface UsernameSectionProps {
	isClaimed: boolean;
	hasPremium: boolean;
	discriminator: string;
}

export const UsernameSection: React.FC<UsernameSectionProps> = observer(({ isClaimed, hasPremium, discriminator }) => {
	const { t } = useLingui();

	return (
		<div>
			<div className={styles.label}>
				<Trans>Username</Trans>
			</div>

			<div className={styles.actions}>
				<Button
					variant="primary"
					small
					onClick={() => ModalActionCreators.push(modal(() => <FluxerTagChangeModal />))}
				>
					<Trans>Change Tag</Trans>
				</Button>
			</div>

			<div className={styles.description}>
				<Trans>Change your username and 4-digit tag</Trans>
			</div>
		</div>
	);
});
