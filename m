Return-Path: <linux-kernel+bounces-351605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7798D991388
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 02:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9873C1C22114
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 00:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B3CDEAD5;
	Sat,  5 Oct 2024 00:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RzEY7LBt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B58AD2FA
	for <linux-kernel@vger.kernel.org>; Sat,  5 Oct 2024 00:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728088427; cv=none; b=gB95f3zcTfmseZAFAFVN0nCRX7i+jyoWSHfoHejsN6ESNHPHFLvH54pYsw5iHLGAs3bEZ1G8RuqhBa6s8cXkHRmJMeC0YH85KrEBE+zPlA1cKflW1bxBSBGYRtVyxeVvOaq8Nbh35F93JRtPzzLUM7g+M9/9flQS5gk00VH5j/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728088427; c=relaxed/simple;
	bh=UMCgpa71WZtIX4QdzigfLTepIgPEgD6UpMuLQsbmrsE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=EDkdMQqMLO20uZqkfMLFAKfl2XHOfg2YGBTX6z/fGc8WQLCqsE4N8gMPZmAw9MsjTVu43bFmNzQpo+th0VQ0trGH3OlEDpstDhvGWMKZ1UafAnDvGNKGG6YTfIKRK5CLO/8RMiaOrkhPn2Sj0lckQnejvX+pZ8MWqIM+a7BKI1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RzEY7LBt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 977DBC4CEC6;
	Sat,  5 Oct 2024 00:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728088426;
	bh=UMCgpa71WZtIX4QdzigfLTepIgPEgD6UpMuLQsbmrsE=;
	h=Date:From:To:Cc:Subject:From;
	b=RzEY7LBtvK1CwHV+J35quq2m9Xjowa1NYCcZZ0bUZGGDt3JC/zqaJCLRnZ50xGs95
	 GedYHV2MXN4cNVPStn4ZwkprTQ1QEBvA6FpJZNf1kX/RXD512qbVgXKIOJMm5SbikV
	 DKQzo32tkhvAj++0+H2q9Ye33gDLuAu70K/AJCxdak1GFUCofBEybYFcikAprafWk0
	 R35zRBrFoA6CKzutokdsVchRuCbTKWP+H5HvaGTErWqXWbw8KiMqntKEjc3XYmVedb
	 Ietmlq60vbc2Zm/UH7WtVK2GBk5L/fWx+7GPXj8jt2cMD9FCkzIctaFag8f4GMtPD0
	 24wefPALBNeqw==
Date: Fri, 4 Oct 2024 17:33:43 -0700
From: Kees Cook <kees@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [GIT PULL] hardening fixes for v6.12-rc2
Message-ID: <202410041733.20AD92E@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please pull these hardening fixes for v6.12-rc2.

Thanks!

-Kees

The following changes since commit c121d5cc3a993cdbfab46a152bdd50227a4d5e8c:

  lib/string_choices: Add some comments to make more clear for string choices helpers. (2024-09-05 09:50:16 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v6.12-rc2

for you to fetch changes up to 045244dd5d75c61ae37b7b96fe0a95805bd1842d:

  MAINTAINERS: Add security/Kconfig.hardening to hardening section (2024-09-28 13:56:12 -0700)

----------------------------------------------------------------
hardening fixes for v6.12-rc2

- gcc plugins: Avoid Kconfig warnings with randstruct (Nathan Chancellor)

- MAINTAINERS: Add security/Kconfig.hardening to hardening section
  (Nathan Chancellor)

- MAINTAINERS: Add unsafe_memcpy() to the FORTIFY review list

----------------------------------------------------------------
Kees Cook (1):
      MAINTAINERS: Add unsafe_memcpy() to the FORTIFY review list

Nathan Chancellor (2):
      hardening: Adjust dependencies in selection of MODVERSIONS
      MAINTAINERS: Add security/Kconfig.hardening to hardening section

 MAINTAINERS                | 2 ++
 security/Kconfig.hardening | 4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

-- 
Kees Cook

