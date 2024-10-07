Return-Path: <linux-kernel+bounces-353217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6040992A8B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 13:44:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60BD71F234E6
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 11:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3751D2200;
	Mon,  7 Oct 2024 11:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="gXuvKg2V"
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96631D1F5A
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 11:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728301389; cv=none; b=n4p5ymReccdT3H9qwbOv12GA/wIep+JHPzCdoB7WBa3jYtsFSWEO7gafCnvnMLLWoiATmouO3O9sE2pQIrDT5mq+CwBbdzv8zfqCx+TTowey5sexXbuddPnSTzfqDNrmK1iO5I88zXM8khrm3wNNLp0yDLnKy6nx3zhheCoituo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728301389; c=relaxed/simple;
	bh=/BXBTyE4kPAIV+YfZmmUlRNxUU659nHcV2bf/hjrNBE=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=HyIJae3PFJXc787muqqHvOGTWerm87HRpdifi8o4cRqN11p1XRnmaM/zXV4UaLBU6V0b9Ib2CbuspWw3rSWLGE/MHkayaAtQkH9ac/wsXw32UWZrBJfDvQbQrQQ+AawT3MBnZsWMRMV9hSPPUGehgbE7AxiZ/RfseXxtfO2n3Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=gXuvKg2V; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1728301379; x=1728906179; i=markus.elfring@web.de;
	bh=NAdvvRci/qH4SyInWfc5eb3BE9V/ablTONBTVmrRJpI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=gXuvKg2VAz7HpxxOh0HH8UjyvXEg9uFkUPmBhbVLqe/+oKLVeF6U5rTrPTnKVvqS
	 PRoPt11Q5i4/Phj4Fw9+SJpFhVKH7ZWNuGZGUcMNTnPW0aVxOw/turP4NNFigqSdb
	 vemK/s0lJQSj3wIhdpWuGriu/Dt3lePgHYgBuQL//z8Swap6R0Tbhj2/ENPGub3wP
	 vlfDqkAp/wUcQ/JphlZ6bb8ugU1fzLC57XG3sULvp4JxsCOnOPG+jNFle54e3gN1j
	 b8z1JHny5CJKN86ClGCQHjt9Qc4jdLuSROILKMokYa78NaDZHgHvu3n7eVuuHsGYl
	 IIpt179vbKw2i5YosQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MDv9a-1t7hgB3sMG-00BYNo; Mon, 07
 Oct 2024 13:37:03 +0200
Message-ID: <81ce44fa-a972-44bd-ae80-6144a8ac4c2f@web.de>
Date: Mon, 7 Oct 2024 13:36:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Hsiao Chien Sung <shawn.sung@mediatek.com>,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 dri-devel@lists.freedesktop.org,
 Angelo Gioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Bibby Hsieh <bibby.hsieh@mediatek.com>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>, Daniel Kurtz
 <djkurtz@chromium.org>, Daniel Vetter <daniel@ffwll.ch>,
 David Airlie <airlied@gmail.com>, Mao Huang <littlecvr@chromium.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, Nancy Lin
 <nancy.lin@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, YT Shen <yt.shen@mediatek.com>
References: <20240620-igt-v3-4-a9d62d2e2c7e@mediatek.com>
Subject: Re: [PATCH v3 04/14] drm/mediatek: Fix XRGB setting error in Mixer
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240620-igt-v3-4-a9d62d2e2c7e@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:NUFwNhkscOyDyELqWmI3FAG77svFnNMD9qcpFN+Jv7FYNoq4/il
 Lqkd5arsarOez0n1pZ/3F+SeTSVUjoo6y6MVY+1gBB5CdVnyRKuwDBHo4CQugSvZpaiwI7k
 VYsfKaqBau1PVZH4BWksV9WC2wMEk7JtFHGCUObnqhltQAVSWoa31uEfmkX9m6nlwQuxSV+
 3UK0k+pqVdsKGA202IYLg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Xb+g1JkQl0Y=;bcKYl+AOtZOSgtmTAlh/No2ocWN
 auQSLCTuTOrDbc5aKT9w9crmKl872kE50lFlWmgaSpvneDe3wTAaE+pWPUrStNbL5FKkd0nNP
 Mb7Jur/MnQE69grah3HGHATmc0HT/kZOaPwxU/8lGmkYOd8atl2fiW9KldsssCRxIm4/K36EI
 siI0Ttihl4BfFYXNl2EUN3i+mkhci4JJILBA4zhUgGhfoYhl0O9xTXZOFb2g3Sw3NzvFBC4fG
 +TKbjj6easHTqYnxD3savh34mg4qAvUmM64umYTsvozYGFueHIY8w0KF5LE+9DH5vxUkkdIU1
 3j/isfj/xeWNl73vn50GOHToY0nO9mR28LhxQf8fbQdeEakmNClhtfgeIVRHuE3FC3nGI/Sr0
 AEE+aRPKUb7g3PGpZM7t5p6r2nKOHyfS4mGbgX7wS3DM/3u7q/YHvA6vdpvjNGGSm8fDxktP+
 AnmZXgjiVoV3v+WjMyHT/yDa3VQ/gwY3U2T6oW0Ual0gBqBHTdnrfGl6dLLmK43RVdDkPqzd6
 wh7iyWQHbMFHxrFD0Bv4MPrEBiKHOVgYKWfgV+BdNdtDXxhxOqus5npBJQQf0KAXe78nk8MWl
 abY83TVElpdhjNarclHQgOzhsdbdqySRqIAIFfHkNl/29bJA5gmY3dO1lUv26GPWMaw06ItHP
 vbS1rTrlRY4BCfmCH7J+TZaIC/dVNFGn7uycuoz6CocrI0mdt/0Amh72uwDmR7uNjCcQ5eAp4
 Ggsn0wdexObSKuwb02XkkaMc0f9lh4N8GAJL1t03zTu47K39QE13y0vJonSFmrRdHxh0cpb5p
 Q8GVtHBHvfBzhH5Q6Lwt5zsQ==

> Although the alpha channel in XRGB formats can be ignored, ALPHA_CON
> must be configured accordingly when using XRGB formats or it will still
> affects CRC generation.

  affect?


Can such a change description become a bit nicer with an additional
imperative wording?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.12-rc2#n94

Regards,
Markus

