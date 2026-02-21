import clsx from 'clsx';
import type { ReactNode } from 'react';
import authLayoutStyles from '~/components/layout/AuthLayout.module.css';
import NepornuOfficialLogo from '~/images/nepornu-logo-official.svg';
import styles from './AuthCardContainer.module.css';

export interface AuthCardContainerProps {
	showLogoSide?: boolean;
	children: ReactNode;
	isInert?: boolean;
	className?: string;
}

export function AuthCardContainer({ showLogoSide = true, children, isInert = false, className }: AuthCardContainerProps) {
	return (
		<div className={clsx(authLayoutStyles.cardContainer, className)}>
			<div className={clsx(authLayoutStyles.card, !showLogoSide && authLayoutStyles.cardSingle)}>
				{showLogoSide && (
					<div className={authLayoutStyles.logoSide}>
						<div className={authLayoutStyles.logoIconWrapper}>
							<img src={NepornuOfficialLogo} alt="NePornu" className={authLayoutStyles.logo} />
						</div>
						<p className={authLayoutStyles.logoTagline}>Nebuď na to sám</p>
					</div>
				)}
				<div className={clsx(authLayoutStyles.formSide, !showLogoSide && authLayoutStyles.formSideSingle)}>
					{isInert ? <div className={styles.inertOverlay}>{children}</div> : children}
				</div>
			</div>
		</div>
	);
}
