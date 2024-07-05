Return-Path: <linux-kernel+bounces-242697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9746928B9C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 17:27:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D55191C20E42
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 15:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D7F16B75F;
	Fri,  5 Jul 2024 15:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="J9dWrh77"
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88AD61487C1
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 15:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720193239; cv=none; b=alp9ls/q91mxKtmmLow4IhiZ7UoZ5rJsGcWX3NQvwiOEEnWquOHocoGhzHJupJhGkrPMD1P4MdGefdUHI9xcyAnDLU0yYHqAO5fRMhN0zaXH0KZndmhGIRM17J+9K1gzVEwOwYmfiBdVssX28o1f+VMDj5T5Kmak0lQeh8Xtdh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720193239; c=relaxed/simple;
	bh=/6h0p2NgdVes3zAAuz2TDWC+uOXxK+yalypQWRlvkR4=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=LFDscWeGgLOjyDhD8W8C8k4JxQzCd6Ob1vjbi9eN/5ZM4mwsoizev9yyAIkYjDru2K+wunlF5r8ME4FRj/oTkbrSWSqRzvpSWpLhLGcWZQibsQCaBxkj/JrW6xbCEFNqxUdCJz161SD7UEXz9o9k9W944150X/tfB9f38IbX8MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=J9dWrh77; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1720193177; x=1720797977; i=markus.elfring@web.de;
	bh=6JnxrUOlqbH2mNGsHeA7Vvi/lieV8ve4eKCHNY22ByE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=J9dWrh77ExL55IHtoHg9UexxBIB1DbtXtNZWyZx2CcLCm7ZAopRT05QVgDrwgI4i
	 Fx1WVsR63xBJGTn8w4XU69mpiYeJqTT++7Eqbqd+AtsQc7Fi1t53WBZGph2XgEnb/
	 FslclELTR7MABLKKWpQaANZcel5SqO6ltpBEDr63L9EZcvD/lorqWhsJTdUbvjy7E
	 BBVKLn+36Z1ygzoecQ5RoB4IFcEqYsMYEsnLNPXBScYIAnRrSrhokGtfWAvdWUj0e
	 /1rqvOupHoCZsU7tOEqKwQK82xhok/S75A9a403RBUrp/6yQlrtuAdQX/35L0clrA
	 1Tj/t1wg0Rfw6xu3CQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N0qvH-1sE7ky2rP3-013FjJ; Fri, 05
 Jul 2024 17:26:17 +0200
Message-ID: <e3dc918e-07df-4fd1-b69a-9650a246ff7c@web.de>
Date: Fri, 5 Jul 2024 17:26:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
 linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Vladimir Zapolskiy <vz@mleia.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Li Zetao <lizetao1@huawei.com>,
 Yangtao Li <frank.li@vivo.com>
References: <20240705093851.18107-1-piotr.wojtaszczyk@timesys.com>
Subject: Re: [PATCH] mtd: rawnand: lpx32xx: Fix dma_request_chan() error
 checks
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240705093851.18107-1-piotr.wojtaszczyk@timesys.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lNOiipqr4XlYK+cmZBteRE8mMPYw/wCeZ+u14Ww6uOWGO9szABd
 FxzXJYVNM934Ocz33GU+zcYxPubpf+O0CjTdlrfb0dUoSVLRjLQ06CXqr+uWimHZ9npuX5o
 BedgALtHx3GvG8kHwEBuOgC9UIzpNN3vx9N2BQkQxJFyvRd74s5R7l2LelgxzxLzG7V8M/q
 BRw6CGbfF+KEaRYChm/Zw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:UOTWRfcKhgQ=;RZsdVvtSLb0xq/AQHD6GuOMZe1v
 yHkjXhczTksARmriX/0/1KrtpAQcngmT8mLglKUiSyqa5kxX5iTVBWBzI/2hf2/jN8DhGt2oQ
 foZTPsKoozTi1KSkyDId+oIOsogAJo7Z9O+mOmF5oeAOl12NcthBQ3EXtlt+KfFdzqiwhRYtN
 +y8jVpktVXr0pW4BdTwcVyTuBel5Us2QcZFFtgHxUqzlEBBpGyhyXAuMkcT7SuMMZOmrXCbGd
 a3N6/xIXb4MydUcTb3VuDNR6aXKoRjiNciOXOwbwGkHuw6G7kq6oZe+Mlxbkwof+uwd29W2Tf
 wBhNcVAd1UuHAsR2KPNEmfNJ1HUo9z1TiPOt2aiVv9yhDk5dlWMG+I2V94oPjowHt/wjVBHiu
 6cGxt7PwuVFfrVMY4MymUbkA2u6TDJqQxmnFFqHNlYL4/oz+VXmQdCwH6SWvBgOCmDlO2tybi
 TLrbDUzTU5HugnSLSp3afdbgg2UejdgVgMl9j08BidPFcitaOO761grOSdHZrFvicc3uUy/Kg
 a+G6ataG7Gj3FgQBHW0vM7TD4TAt4W8FARDhAsOgPrwsQrza74gTnwCdM3G8E5rDtmkxT5r6B
 ByYGltDJsYfRdZzGPwWJ6od2gY3Etbj1ZiKUb3TYdlGENOWyd8sqyt4Yt3QPhuNbBFl4cQ4xH
 8HBytZdxvD9i/q0HY+0rzn7YJF9xAKnAzC17MEFmIqcHPC4TI6hr0W0L+vdkyqc+t7S/W6PrX
 2cVfHFKp/8nCLhD1nw5kEKWJGz0CP1DNkmhegUX80OXmgdcO9wN9WSX8ciKT9XZsiRS6mzJ+2
 XBKW4XxjaPYea1g7KshKf89Q3HSES+UZ7rM/3iqK94Xh8=

=E2=80=A6
> dma_request_channel() returns NULL in case of error =E2=80=A6

* I find this information not relevant here because such a function
  is not called at the affected source code places.

* Please improve such a change description with imperative wordings.
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/submitting-patches.rst?h=3Dv6.10-rc6#n94


> Fixes: 7326d3fb1ee3 ("mtd: rawnand: lpx32xx: Request DMA channels
> using DT entries")

Please omit a line break from the tag summary.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.10-rc6#n145

Regards,
Markus

