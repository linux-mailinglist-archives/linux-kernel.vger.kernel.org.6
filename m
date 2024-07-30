Return-Path: <linux-kernel+bounces-267445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A68941191
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 14:09:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BDC12831E9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 12:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C3919DF8E;
	Tue, 30 Jul 2024 12:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rZQKWKBf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02304199236;
	Tue, 30 Jul 2024 12:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722341338; cv=none; b=IYaOogl2UFZnyOJdKr0KNvO1DXhkyOYJycSgDm/6gfQbqgFxJtYDDYZKYENFq7H67r9IL0LwrOsJ3eH1nwfZ+/Tleq/ObSQaCoVEPsYKjJEQx1+eQWO8vVfnO0qBUV1CmgqSlbs93JWGkMaBmgUbPVEif+reDXEMn93Vif1STGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722341338; c=relaxed/simple;
	bh=oZgKN1ReguQocq3wV85Pte61m1OvjCGZvQp7Jwv+uVA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=XMQh8eOjyzUio0Oja4Z7/V4Ialf9x6J+olE6VG1WyhNmhQ7rWYy2fUFYq2PDYBUS80Rp7QZh+Gc3DVeQxBpj2qA0GW/miv2983etx/nf0wfdDOL6l4Wgs0Q8JhMuLUHMZ3CVfgP2gAJ9ndShK8y5+XeHwtngxfg0azxj9TSErDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rZQKWKBf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83F90C4AF0B;
	Tue, 30 Jul 2024 12:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722341337;
	bh=oZgKN1ReguQocq3wV85Pte61m1OvjCGZvQp7Jwv+uVA=;
	h=Date:From:To:Cc:Subject:From;
	b=rZQKWKBfZCdbDDMHQrl2rAhGCsSnSaRyyZ2HX2YlCAj5+5bHw5haeZUl6DBqjqCdU
	 +JVm0K+YK5DU9eB027EX3iE9MMU0BiS1d/X/LrOtG4E1YjOjgOAWIqTRQNFgRnJeOZ
	 HzptvjFgXxTrv7PijBh8qRE8Bu64ZmIY4kIMvTmWSHN5rDqUhgENxJdoxRxF816Duw
	 pI020dx+MfTk9yIdHWVf9kSi4idC3QEn/FMPa1W4oKLbe1aof34zw+U3XpG13ADftR
	 eeiVFt2nBppzQr3uZJmKWJtVza8N7RTEbMD+QdEgWN7ea1sfWfqvZ0dazRs4kWitbL
	 lAwKWYuQGPQOw==
Date: Tue, 30 Jul 2024 20:08:54 +0800
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: torvalds@linux-foundation.org
Cc: tzungbi@kernel.org, linux-kernel@vger.kernel.org,
	chrome-platform@lists.linux.dev
Subject: [GIT PULL] chrome-platform fixes for v6.11-rc2
Message-ID: <ZqjX1lwASMRAxAdm@tzungbi-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="adrtwPlj+pL8w0Qo"
Content-Disposition: inline


--adrtwPlj+pL8w0Qo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please pull chrome-platform fixes for v6.11-rc2.

Thanks,
TzungBi
------

The following changes since commit 4baf1cc54433ff7c6e5178517bc8768001416681:

  power: supply: cros_charge-control: Fix signedness bug in charge_behaviour_store() (2024-07-05 01:51:33 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git tags/chrome-platform-fixes-for-v6.11-rc2

for you to fetch changes up to df615907f1bf907260af01ccb904d0e9304b5278:

  platform/chrome: cros_ec_proto: Lock device when updating MKBP version (2024-07-30 19:48:35 +0800)

----------------------------------------------------------------
chrome-platform fixes for v6.11-rc2

Fix a race condition that sends multiple host commands at a time.

----------------------------------------------------------------
Patryk Duda (1):
      platform/chrome: cros_ec_proto: Lock device when updating MKBP version

 drivers/platform/chrome/cros_ec_proto.c | 2 ++
 1 file changed, 2 insertions(+)

--adrtwPlj+pL8w0Qo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS0yQeDP3cjLyifNRUrxTEGBto89AUCZqjX1gAKCRArxTEGBto8
9L8hAP97NNwfIuLMJk3apnyzlQp3JX6JFkigWRLhk1nB+WxCPwEAtvgDxY3BybnA
R+sF7Xt/Ag1qh4qSdaRI2Soz/jmy1AI=
=e6/i
-----END PGP SIGNATURE-----

--adrtwPlj+pL8w0Qo--

