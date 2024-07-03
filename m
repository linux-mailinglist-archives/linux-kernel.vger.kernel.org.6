Return-Path: <linux-kernel+bounces-239305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE5C9259B8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 12:48:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE8791C21D25
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 10:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B86177986;
	Wed,  3 Jul 2024 10:39:22 +0000 (UTC)
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3626416DECF
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 10:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720003162; cv=none; b=Vvo5VFvxFPXqxoAbwAaD4Nhkdqkzg6VlSD9u7J8FMNt1gR96Ki+uLYUw7xRcQUQkVCP1DWYy1zmYpLC1xpfhV5K25HF+NqmN+REPGfWAFDLYdc1df/UO+4YHTDAQo+GEtF1RUyzD9Hgx7dPVPS89yXqUnUgNrfsqxO+8eD8hv/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720003162; c=relaxed/simple;
	bh=DfCOs+Uh49YR9cOQOpraFaVAi5ot/dscCajlnNC7m5E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W/sFJ6fgjhgwrBg4tPjJ4uCUQCFvGgEdT3MfrmwoMdhAXUyogyBtvnaMjCjw2S2cyHgso0lQOM/kJsX1EQba4cVFcA6Wl98RK87cTqx7wF9S6WryOZI5jtsLc3hiRB9jlUbRHMI1TlecU/4lMCH0c5zebsganTz38Ww+7IvR94w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
X-QQ-mid: bizesmtpsz9t1720003071tpz2sub
X-QQ-Originating-IP: tPq2Z00b0loLhBPfxiZCnsYVWGynSo7q+PcRQPMmOtw=
Received: from [10.20.53.89] ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 03 Jul 2024 18:37:49 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 17256580716429354049
Message-ID: <2B5581C46AC6E335+9c7a81f1-05fb-4fd0-9fbb-108757c21628@uniontech.com>
Date: Wed, 3 Jul 2024 18:37:48 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nvme/pci: Add DEEPEST_PS quirk for Lenovo N60z laptop
To: kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
 guanwentao@uniontech.com, huanglin@uniontech.com
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <C0A44727E997523C+20240703101513.72590-1-wangyuli@uniontech.com>
From: WangYuli <wangyuli@uniontech.com>
Autocrypt: addr=wangyuli@uniontech.com; keydata=
 xjMEZoEsiBYJKwYBBAHaRw8BAQdAyDPzcbPnchbIhweThfNK1tg1imM+5kgDBJSKP+nX39DN
 IVdhbmdZdWxpIDx3YW5neXVsaUB1bmlvbnRlY2guY29tPsKJBBMWCAAxFiEEa1GMzYeuKPkg
 qDuvxdofMEb0C+4FAmaBLIgCGwMECwkIBwUVCAkKCwUWAgMBAAAKCRDF2h8wRvQL7g0UAQCH
 3mrGM0HzOaARhBeA/Q3AIVfhS010a0MZmPTRGVfPbwD/SrncJwwPAL4GiLPEC4XssV6FPUAY
 0rA68eNNI9cJLArOOARmgSyJEgorBgEEAZdVAQUBAQdA88W4CTLDD9fKwW9PB5yurCNdWNS7
 VTL0dvPDofBTjFYDAQgHwngEGBYIACAWIQRrUYzNh64o+SCoO6/F2h8wRvQL7gUCZoEsiQIb
 DAAKCRDF2h8wRvQL7sKvAP4mBvm7Zn1OUjFViwkma8IGRGosXAvMUFyOHVcl1RTgFQEAuJkU
 o9ERi7qS/hbUdUgtitI89efbY0TVetgDsyeQiwU=
In-Reply-To: <C0A44727E997523C+20240703101513.72590-1-wangyuli@uniontech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1

Sorry, please just don't merge this patch!!!


Just a few minutes after I sent this patch, right now (after I quiesced 
this lenovo n60z laptop for 10 hours),

its nvme disk crashed again! Just like before, nothing can wake it up 
except a reboot.


This is very surprising and it seems that only 'NVME_QUIRK_NO_APST' is 
the correct choice.

I'm sure that 'NVME_QUIRK_NO_APST' will not have the same problem, I 
have tested dozens of devices of the same model before.


I will send patch v3 to revert the code to its original state.


-- 
WangYuli <wangyuli@uniontech.com>

