Return-Path: <linux-kernel+bounces-215476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D4C9909353
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 22:21:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3022C1C22C4A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 20:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21072171E71;
	Fri, 14 Jun 2024 20:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="BxuBcVfO"
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3674360DFA;
	Fri, 14 Jun 2024 20:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718396487; cv=none; b=rWrGsOMUO8gZgH4wF27ZTuq2sQpdrBZD1Qh2+q9YYhX7C+AcdmkNvT8104wAPCqezqdkpHsHDR7mmGdeZlcybyFq9ZB29Dgz9CGhMDA7W/GQ/VJrnY8S+vABXCodb2O4xtDby02nxkXb+lZk95JhUxek3FVj1QKdIOVsMjdTaAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718396487; c=relaxed/simple;
	bh=zOh+hF8DXM+wCYZsR55XDS2e7+n2zj7KiZbsrftT9OU=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=QMGAiXiJSK6Qo7kCjM0sF4EdfNslSG3mbItuO/hcgvZIinGEy9Val0cYepFJasU2bkfswOWLkzLS6l1y6zZC1Q/Q3JwhnlsL1Ii7JhVmaM+u1WM5j1DOIpC4Xt+InR6nU5vYGuF0bw+bdoMWd3hTlDQtANnHG1w0rE/r2aROkH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=BxuBcVfO; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1718396442; x=1719001242; i=markus.elfring@web.de;
	bh=4KdjCxBK2/pLnJ4qkHyvgFRW80WnBs0PeXd1YKVdud8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=BxuBcVfOYDvY+1qIktKFAqvG2NyzKXg+jhMQJCd9smzQvubLQgupjPA83fTOkizl
	 zH/6aJ2gsjpTvtMqY8CgtgCA0mQHH4SNjp9q6amT+lamepDdHT0UfrmQiGzHjMp0B
	 5PjV5MSNf9AN5xsW0CUr2N6DOHxQ7Och75+NDL9iTTfR7FIbR590k6g0wJVbizScA
	 S+zujcIuMBmWj8pjvZ7qDl1/qf9qIZ+CLsqKTjfwdtKeoCK0CYyzb20+CWAtA/2m8
	 FI3IFSET1+mPOJYSW+t64wtBuQgxibqrxi7oW2W78+ndCT2vlOSuJIiH7p/xMfMzY
	 PF5twRWAYsuivVHzrw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M604f-1sLGTa3jdD-00DwES; Fri, 14
 Jun 2024 22:20:41 +0200
Message-ID: <083cd51b-06d8-4618-8517-a2bc2fa31554@web.de>
Date: Fri, 14 Jun 2024 22:20:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Hao Ge <gehao@kylinos.cn>, linux-sound@vger.kernel.org,
 Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Shenghao Ding <shenghao-ding@ti.com>,
 Takashi Iwai <tiwai@suse.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Colin Ian King <colin.i.king@gmail.com>
References: <20240614024116.22130-1-hao.ge@linux.dev>
Subject: Re: [PATCH] ASoc: PCM6240: Fix a null pointer dereference in
 pcmdevice_i2c_probe
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240614024116.22130-1-hao.ge@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XOJM/qaDGjcj4FvHjrKztjXIoneCDYiYIfC8036DqTPH0JKDqDQ
 dQHpox1P/5oxCdzAa8mGSlqpkyNqfGlxkDVfllKh/5aTX0+uj+7l1G6aLloHN6tvJa5VFF0
 Y4rJNLHeW0KEQ+bO6XFPQXWqxr+g9eMu/nhMmydAQoRROyB/nYuGKZpq7v0fPBiuh9JqkoQ
 3DED8GayWJS8AIBTPAi7w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:2cv1dvyzcOM=;prvPWqHN9aM9/tNDwq0/vd1heIP
 2K9yrELvlf4JHKfNAKV4hED4qIGbVV7u7fZ7yiz8vQHme5l8fpcQ7FJNV8gG05hYyOnYgHY/d
 fJU1t34aQawC1VB22IuU6Zr+6JdWVBLmRJYBGRSTUNtw3K11lcDxFgYmQMPnqlG/LPVpPoIWx
 T86sI8SsAk+IwTqEbBBF60DiSoTx+GrygVkkP4M2WGxIohOqNFJPeWNbWlUEWQ2n0/btviuaI
 jqo4+cSwFUzagWweEF9MGNhw3t3wNwrWka0m8gsMplnFzW6Gv8rAWlVEATrEn3Xub4SN6Tmd3
 ijNuilMaeRqSYLXmhXDuSL9qpcU3rT9c09KBLvWuJV34Ss3bdZeP0ffZG1k+29p1AwezioD9z
 cNopnj4xhVPhutKw3pk88/YpbTI3tUcKGMMuuSmUNyNtM/rehSE24VpCBPzdRlbpkJrlvl9/5
 OV4eyDRGHElWi0FFVi1PdaW4o0fmd0MNZHJPEE6l+jbBslIWsNiAA34c3iZT2KCyJI4qEZqn0
 62LQRsEKMAS8cnMbrWzAOxynYyyaTTunZFwVaHxW8NR3VqPJmBVDqUDGf31EfNDtuk/PoidFk
 XqoJLRpXvbGvd0JshL/Gy/wANdjEum78YZMbFIlVQ4+cDh581tMgWZD6WoSw9hDbaH5lTTDMc
 mEzOggmTTMnhgxIyRTzv3Dg7roAkkqwSMX724FDWO86Y59ZxLtRLH/a0/G/3BmsDLJn6R6J1R
 0uzMCyPwY5b0myLO2wU4BViCwuV/oHzbvg4drdFX94+yYyTrYuCbI1bCqfcIe+hAD7OGkboqm
 tdtVOHU0cshReS2TJrjEZeE7T58w2Z5X5hJ4is3OOJJ/8=

> When devm_kzalloc return NULL,we return -ENOMEM directly to

This information fits to a coding style advice.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/coding-style.rst?h=3Dv6.10-rc3#n532


> avoid a null pointer that call pcmdevice_remove which will
> perform some operations on the members of the pcm_dev;

You pointed in an improvable way out that the label =E2=80=9Cout=E2=80=9D =
was questionable
after the assignment of a well-known error code at the beginning.
https://elixir.bootlin.com/linux/v6.10-rc3/source/sound/soc/codecs/pcm6240=
.c#L2077


Can a wording approach (like the following) be a better change description=
?

   The value =E2=80=9C-ENOMEM=E2=80=9D was assigned to the local variable =
=E2=80=9Cret=E2=80=9D
   in one if branch after a devm_kzalloc() call failed at the beginning.
   This error code will trigger then a pcmdevice_remove() call
   with a passed null pointer so that an undesirable dereference
   will be performed.
   Thus return the appropriate error code directly.


Can a summary phrase like =E2=80=9CReturn directly after a failed devm_kza=
lloc()
in pcmdevice_i2c_probe()=E2=80=9D be also helpful?

Regards,
Markus

