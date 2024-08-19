Return-Path: <linux-kernel+bounces-292904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C3E995764E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 23:01:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE76A1C239CA
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 21:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE2815921D;
	Mon, 19 Aug 2024 21:01:11 +0000 (UTC)
Received: from forward200d.mail.yandex.net (forward200d.mail.yandex.net [178.154.239.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50F72C18C;
	Mon, 19 Aug 2024 21:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724101270; cv=none; b=E42eYAAtnElTkeegl2rUEumSRa+ueFEZk3IeY9n7MkXUaYoT+gXW83oH01zlkfHi3pqp7qCrn1og0vRNEnhQJg4sEpd4NQZBXjU/CuWDkH6agWO5K0opxYk55d5ez0xnNxrelVY7ql+5UlZn1bzCXct23gC8EWgz/O2gzZKv1AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724101270; c=relaxed/simple;
	bh=cUtmaoSmD+5Qk5UfBM3mcsvWY438nhLilFqO9oMxYOs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IB4SMrmwUal60DvcIAwVgmDIKtzQqTWYAnaaYcp2Dm+LpF3Iu+3+f0ertXgSTF6C2NFqDq8hTpfDC1FO5sWB/OvOQTb8rFFSJk1Xb8sqWjkZw4O/c/4WV3muvRIhGJe1vV74hmJ1KDSfuDghP4y4EDpy/EjaQmaVzhCQwQrVr0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=travitia.xyz; spf=none smtp.mailfrom=travitia.xyz; arc=none smtp.client-ip=178.154.239.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=travitia.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=travitia.xyz
Received: from forward200a.mail.yandex.net (forward200a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d200])
	by forward200d.mail.yandex.net (Yandex) with ESMTPS id CF04863A20;
	Mon, 19 Aug 2024 23:53:14 +0300 (MSK)
Received: from forward103a.mail.yandex.net (forward103a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d103])
	by forward200a.mail.yandex.net (Yandex) with ESMTP id B2A17647A2;
	Mon, 19 Aug 2024 23:53:14 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-54.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-54.vla.yp-c.yandex.net [IPv6:2a02:6b8:c15:2c8f:0:640:f9cc:0])
	by forward103a.mail.yandex.net (Yandex) with ESMTPS id C4E89608CC;
	Mon, 19 Aug 2024 23:53:06 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-54.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 0rTjhaYf4Gk0-VS3IpDkM;
	Mon, 19 Aug 2024 23:53:05 +0300
X-Yandex-Fwd: 1
Authentication-Results: mail-nwsmtp-smtp-production-main-54.vla.yp-c.yandex.net; dkim=pass
From: Jens Reidel <adrian@travitia.xyz>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Charles Keepax <ckeepax@opensource.cirrus.com>,
 Richard Fitzgerald <rf@opensource.cirrus.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux@mainlining.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Missing documentation for Audioreach topology files
Date: Mon, 19 Aug 2024 22:53:00 +0200
Message-ID: <7721158.EvYhyI6sBW@ceres>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi everyone,

I am currently bringing up Xiaomi SM8450/SM8475 mobile phones and have a few 
working well enough to try and get the WCD and audio in general working. All 
is fine, until this:

[   35.366229] qcom-apm gprsvc:service:2:1: Direct firmware load for qcom/
sm8450/Xiaomi 12-tplg.bin failed with error -2
[   35.366244] qcom-apm gprsvc:service:2:1: tplg firmware loading qcom/sm8450/
Xiaomi 12-tplg.bin failed -2
[   35.366250] qcom-apm gprsvc:service:2:1: ASoC: error at 
snd_soc_component_probe on gprsvc:service:2:1: -2

After searching around a bit, I stumbled across this Linaro repository: 
https://git.codelinaro.org/linaro/qcomlt/audioreach-topology
Apparently you're supposed to write the topology in a M4-preprocessed file that 
gets turned into an ALSA UCM topology config and then compiled with alsatplg.
However, there is zero documentation on the preprocessor macros and how you're 
actually supposed to write the topology file. Am I missing something or is 
there no public documentation and tooling for how to use this kernel 
interface?

Best regards,
Jens



