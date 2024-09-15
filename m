Return-Path: <linux-kernel+bounces-330035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B569798BB
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 22:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B61228270B
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 20:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91DA53B1A4;
	Sun, 15 Sep 2024 20:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qqWSZtDF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E825F171AA
	for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 20:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726432861; cv=none; b=gcg9OeSIjtWux9nmFiN6CLF9BLrQjdbUq3c5i8wPf9mhLJuRzRABmm5bV8LHcVfWsh3WnuIpYNBZ8fyWvs9zy2WTgcC98UHGubk3dwbcP++Ie/RbeJyOVSjr1lhUa4Ufux69+j6SyWgJVnm2hRKZhN7irp/OUiz81YNwCypNooA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726432861; c=relaxed/simple;
	bh=g285pEF9WsFiGi081/Ve50iWty2AyB6ySZodtIjFphc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=YKgbIoYSRTLrGR56IN7c9To82XrqQJUfW/qnNYVEZ8Wu8DGa1Kd5/ZZ0dXkladdSFQYRthHr4ql+F2Xq/5OISr7r7t/IcQmYC79m8Z0e21fgsGGyaRYm4H+/jbs4qCDbya3LWN5acUAdmRCE6BVI7IS2XaokZ/yxDSOWWBX8Cq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qqWSZtDF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4946FC4CEC3;
	Sun, 15 Sep 2024 20:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726432860;
	bh=g285pEF9WsFiGi081/Ve50iWty2AyB6ySZodtIjFphc=;
	h=Date:From:To:Cc:Subject:From;
	b=qqWSZtDFXN7EB/tWN40anF8BRUKffVspGDz2Wi28FtKvmmEmXeAxXoAsf/P7vT5je
	 lRXJgq2esToJkxfrq95DJDDeyZQLtl6uL0sLCvW3CoVEMHifNmRl0/lKX7Qlf9J9nu
	 hN2LUwz/bWG54adZvUr+b2DWciIODS251NgQ0SoaHkv+vXUCsl6fJC3Hpqkr0FUcQL
	 awzoBiyY0ZdzVTQR7Y0UyBRyap1QuE+qgPUoQmMKO1yxhxfoacYr3EoXbaCaZ0rabX
	 Ntofy4O2hzvoYYxcjAvMNbIlswDs9lYmhKdAGHzqZqOmrMBq67UVZQICLJ6fiFK8ZV
	 LQtliNjjlpiJQ==
Received: by mercury (Postfix, from userid 1000)
	id 9CB171060578; Sun, 15 Sep 2024 22:40:57 +0200 (CEST)
Date: Sun, 15 Sep 2024 22:40:57 +0200
From: Sebastian Reichel <sre@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org
Subject: [GIT PULL] hsi changes for 6.12
Message-ID: <admkep5qycck3n6inbs52dytfojer5jddjjjzocxi25yirb246@33rwujlrfym5>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nbhs5k7cbkf77ryp"
Content-Disposition: inline


--nbhs5k7cbkf77ryp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 8400291e289ee6b2bf9779ff1c83a291501f017b:

  Linux 6.11-rc1 (2024-07-28 14:19:55 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-hsi.git tags/hsi-for-6.12

for you to fetch changes up to c3eddf5e8c30adb6f43fc0b149e88b9feb76f381:

  HSI: omap-ssi: Remove unnecessary debugfs_create_dir() error check (2024-08-27 15:28:56 +0200)

----------------------------------------------------------------
HSI changes for the 6.12 series

 * omap-ssi: remove unnecessary debugfs_create_dir() error check

----------------------------------------------------------------
Yang Ruibin (1):
      HSI: omap-ssi: Remove unnecessary debugfs_create_dir() error check

 drivers/hsi/controllers/omap_ssi_core.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

--nbhs5k7cbkf77ryp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmbnRlYACgkQ2O7X88g7
+prU9xAAi9WJgTUZ9Eutpsre5R77CoF71zVRF2my1jH+ciMfhVUV7r3BBcJmoWot
uZehebzG75QOvlGQLi/y1bE05Z2idB6GSChIt2aj5+SL31qUhSyDbTZGrArEDlyt
F5425J1+hp5a/MkkrA7Ao2Ulj29M+ULL3mG4ICLYLKnkG4GfvHJn7M58PvUePg6a
+RzeRcIveu12J6hHvyuDPq4QdSusOMIO3eUSexzcSlgZg7lKPWG/VTJz/3iYRhNK
FaENzea12z21tvZ5WurjWq5ew8yD4K1DCJsc5ZtexePYKo5wptytoUoGou0OvpwT
TKeJgxQ8LkdpMYMX3kgN1UZDvrF/8i+5ATMkjt+2cAiAT05qRMLc8e/ix5BwNip/
AE1LxiFI91zdR6LE5Yn1SQVHs5lHBbmiCirhSKz7gnblCokA4LeQ2fc14OEhl4KW
1DLAjgi24xn3jgKfBnRGjLwhnMK2boEAUgCg8P8aCA6Dp+LfvHFGgsa+e6Rrdmsl
kAb+Ivafgi0qviraOdgCWOs89Dhi4h5Yt+/0PCIqM0/0BG7/EoSv6wSGDrV8UWF/
Q6a9xuIPJG1hO7NhD/VlG6Nw1E/oEMHBio2fG1pvxfkuUTX96KaNIcjCW2PBhHZ7
eYEtbxUiHSsb/RN1Lk9BTDPVE+NQ7veG0Nj2VcVFO9YroeF6cGM=
=2ULi
-----END PGP SIGNATURE-----

--nbhs5k7cbkf77ryp--

