Return-Path: <linux-kernel+bounces-173587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E148C0277
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 19:01:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A03E61F25562
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 17:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A47200CD;
	Wed,  8 May 2024 17:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fV0QUJ9Q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791141CAA9
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 17:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715187674; cv=none; b=PPY7PeV01L/WeUh7NKTZktMWPYJtYFVbG54DH5JVG/baT7zEmdiW965tiGk0Yy5HrQYF5z/oPVeQ5fUl4Jp8noNPzyiswmnNXG3xXqDis/Tp9+7ao/gvzyUGsx2bmL/KSwlNLPiiWndRjtSgPjeK8a/wf/euXGrlyPgHPZ+K/w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715187674; c=relaxed/simple;
	bh=FMJFBDiSCdBsBT2PmQNcWcdKdSkvkpDr0aniji9wYyI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=EAl8TTGeSZ+/dvt9Z7yzIc9P+CJBUVg8yll26A3Aaks+VgXmC+gYQG8C8ISkCLPY2o8pVKpVOcCmUO1USv9UMS5dWy3hvW79GgYG/XS+Cg7upp0g2fS4EOKMsEvtZJePsHE5zzGgj/YWLMXvj2rNk4YtTJeQldcu0AHUljfkMaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fV0QUJ9Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A849C113CC;
	Wed,  8 May 2024 17:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715187674;
	bh=FMJFBDiSCdBsBT2PmQNcWcdKdSkvkpDr0aniji9wYyI=;
	h=Date:From:Subject:To:Cc:From;
	b=fV0QUJ9Q166rd5oWci/0EvcxDBRDGtfLUvgVwuN6jidyqFVoGlPt01PVR7+kKbzFc
	 L0whluV/mMR79zjqpc2LRE8fho7mrnkdYHGofHJcm4WAeTacGAK1/PY8xRCuB8baj6
	 KnafL9lfowQKa/dgPD0O+6rQlg4eLGtzWKIJsEiUJyC6ykDB5fePOMNUG1ZO16i8pU
	 fiLQLCKCPnuVUQWxoCbdzfN0cD7uVSE936fEJrw9ZztpVJMoXY38T2QwiQMSjoUFBo
	 ZhAT0I52e7LuRlylNfLML3fC1P7dMfsNF9pZfc48J8v36lrrFl0p2PBjx5uk3Na1qn
	 9kmajbijNxvew==
Message-ID: <baff2bab-3aad-41a6-a0a9-5be64bb2ef43@kernel.org>
Date: Thu, 9 May 2024 02:01:11 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Chanwoo Choi <chanwoo@kernel.org>
Content-Language: en-US
Subject: [GIT PULL] extcon next for v6.10
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Chanwoo Choi <chanwoo@kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>,
 MyungJoo Ham <myungjoo.ham@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Dear Greg,

This is extcon-next pull request for v6.10. I add detailed description of
this pull request on below. Please pull extcon with following updates.

Best Regards,
Chanwoo Choi


The following changes since commit ed30a4a51bb196781c8058073ea720133a65596f:

  Linux 6.9-rc5 (2024-04-21 12:35:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon.git tags/extcon-next-for-6.10

for you to fetch changes up to 3e8e45b65d9f3f1811c020325a306da0f01e485b:

  extcon: adc-jack: Document missing struct members (2024-05-09 01:03:39 +0900)

----------------------------------------------------------------
Update extcon next for v6.10

Detailed description for this pull request:
- Covert to platform remove callback with .remove_new ops
: extcon-adc-jack.c/extcon-intel-cht-wc.c/extcon-intel-mrfld.c
: extcon-max3355.c/extcon-max77843.c/extcon-usb-gpio.c/extcon-usbc-cros-ec.c

- Switch to use dev_err_prove() on extcon-intel-mrfld.c

- Remove unused of_gpio.h on extcon-rtk-type-c.c

- Select IRQ_DOMAIN config instead of dependency for extcon-max8997.c

- Use returned error instead of -ENOMEM for extcon-intel-mrfld.c
----------------------------------------------------------------
Andy Shevchenko (3):
      extcon: intel-mrfld: Switch to use dev_err_probe()
      extcon: intel-mrfld: Don't shadow error from devm_extcon_dev_allocate()
      extcon: realtek: Remove unused of_gpio.h

Randy Dunlap (1):
      extcon: max8997: select IRQ_DOMAIN instead of depending on it

Uwe Kleine-König (7):
      extcon: adc-jack: Convert to platform remove callback returning void
      extcon: intel-cht-wc: Convert to platform remove callback returning void
      extcon: intel-mrfld: Convert to platform remove callback returning void
      extcon: max3355: Convert to platform remove callback returning void
      extcon: max77843: Convert to platform remove callback returning void
      extcon: usb-gpio: Convert to platform remove callback returning void
      extcon: usbc-cros-ec: Convert to platform remove callback returning void

Yang Li (1):
      extcon: adc-jack: Document missing struct members

 drivers/extcon/Kconfig               |  3 ++-
 drivers/extcon/extcon-adc-jack.c     |  8 ++++----
 drivers/extcon/extcon-intel-cht-wc.c |  6 ++----
 drivers/extcon/extcon-intel-mrfld.c  | 26 +++++++++-----------------
 drivers/extcon/extcon-max3355.c      |  6 ++----
 drivers/extcon/extcon-max77843.c     |  6 ++----
 drivers/extcon/extcon-rtk-type-c.c   |  1 -
 drivers/extcon/extcon-usb-gpio.c     |  6 ++----
 drivers/extcon/extcon-usbc-cros-ec.c |  6 ++----
 9 files changed, 25 insertions(+), 43 deletions(-)

