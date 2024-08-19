Return-Path: <linux-kernel+bounces-292910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86B8F95765D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 23:13:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4308E28389E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 21:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCEC417AE1D;
	Mon, 19 Aug 2024 21:13:12 +0000 (UTC)
Received: from forward103a.mail.yandex.net (forward103a.mail.yandex.net [178.154.239.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9650515B54A;
	Mon, 19 Aug 2024 21:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724101992; cv=none; b=p1Wzi2B/wb54a3WLIzUSHUdLu8pG9y748h+07QNYZT4wYeg9BKKtN1dEXL5dH8/3kybgF65qtmIlAlv84jL2P6r2IOOh1b12VcIUhhmX1Bn7qcGzt5YMMBWEri6Hzvn0QvkSbHUk1yLlaUpJpMrkk2uPynglfzbBXWpni32ggHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724101992; c=relaxed/simple;
	bh=8q0WH81KOzQ0VnX3CzGiCxpYkfMgPsiVafwJsIeA5Tw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type; b=mzVSiZzQPfA7o6YJMd8SkeXZDtRBcFs4EXfEI4DAmV0kaaXtdmkunkGewMU9O/jzU+tVyLI337ZxDt0tRDMW7C9V6K+Y1Ji2Dl5ehnhC+c015heAwVoQaVY1NrklGwcH3h5ZfYbD37NgXE7tgPCsmWm0kXa0FDX/fkNDaVQFwIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=travitia.xyz; spf=none smtp.mailfrom=travitia.xyz; arc=none smtp.client-ip=178.154.239.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=travitia.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=travitia.xyz
Received: from mail-nwsmtp-smtp-production-main-55.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-55.vla.yp-c.yandex.net [IPv6:2a02:6b8:c0f:604:0:640:5e0e:0])
	by forward103a.mail.yandex.net (Yandex) with ESMTPS id 9705A608FD;
	Tue, 20 Aug 2024 00:13:08 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-55.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 4DUofCX6WeA0-gWrBvOJJ;
	Tue, 20 Aug 2024 00:13:07 +0300
X-Yandex-Fwd: 1
Authentication-Results: mail-nwsmtp-smtp-production-main-55.vla.yp-c.yandex.net; dkim=pass
From: Jens Reidel <adrian@travitia.xyz>
To: krzysztof.kozlowski@linaro.org
Cc: adrian@travitia.xyz, broonie@kernel.org, ckeepax@opensource.cirrus.com,
 lgirdwood@gmail.com, linus.walleij@linaro.org, linux-kernel@vger.kernel.org,
 linux-sound@vger.kernel.org, linux@mainlining.org, perex@perex.cz,
 pierre-louis.bossart@linux.intel.com, quic_srivasam@quicinc.com,
 rf@opensource.cirrus.com, srinivas.kandagatla@linaro.org, tiwai@suse.com,
 ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: Re: Missing documentation for Audioreach topology files
Date: Mon, 19 Aug 2024 23:13:04 +0200
Message-ID: <4618258.LvFx2qVVIh@ceres>
In-Reply-To: <f4a9c58e-a7cb-4786-9293-85e1a3f538ad@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

> On 19/08/2024 22:53, Jens Reidel wrote:
> > Hi everyone,
> > 
> > I am currently bringing up Xiaomi SM8450/SM8475 mobile phones and have a
> > few working well enough to try and get the WCD and audio in general
> > working. All is fine, until this:
> > 
> > [   35.366229] qcom-apm gprsvc:service:2:1: Direct firmware load for qcom/
> > sm8450/Xiaomi 12-tplg.bin failed with error -2
> > [   35.366244] qcom-apm gprsvc:service:2:1: tplg firmware loading
> > qcom/sm8450/ Xiaomi 12-tplg.bin failed -2
> > [   35.366250] qcom-apm gprsvc:service:2:1: ASoC: error at
> > snd_soc_component_probe on gprsvc:service:2:1: -2
> > 
> > After searching around a bit, I stumbled across this Linaro repository:
> > https://git.codelinaro.org/linaro/qcomlt/audioreach-topology
> > Apparently you're supposed to write the topology in a M4-preprocessed file
> > that gets turned into an ALSA UCM topology config and then compiled with
> > alsatplg. However, there is zero documentation on the preprocessor macros
> > and how you're actually supposed to write the topology file. Am I missing
> > something or is there no public documentation and tooling for how to use
> > this kernel interface?
> 
> Hi Jens,
> 
> I am not aware of any documentation related to audioreach topology. I
> used existing code as example/starting point and then with learning of
> internals and digging I managed to get some grasp, but it was all
> without any docs.
> 
> If your platform uses reference Qualcomm components, like WSA speakers
> on Soundwire bus, then most likely you can re-use HDK8450 topology or
> anything newer.
> 
> Best regards,
> Krzysztof

Hi Krzysztof,

Thank you for the quick reply. On all Xiaomi devices of this generation, the 
speaker amplifiers are connected via I2C (they are mostly cs35l41, some cs35l43 
and awinic parts). The audio topology therefore probably differs a fair bit 
from HDK8450.

Best regards,
Jens



