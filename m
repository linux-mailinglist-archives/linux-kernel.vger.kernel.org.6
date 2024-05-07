Return-Path: <linux-kernel+bounces-171459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A38FD8BE490
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 15:45:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57EEA1F296F4
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 13:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D1915E205;
	Tue,  7 May 2024 13:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="keVULDMX"
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9E013C3FA;
	Tue,  7 May 2024 13:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715089547; cv=none; b=RgYdPn8upu3lfUdCdG3OZgTvY8TLJD3LcsWUae7+sluuZLV029IN6ex4juWqzqUPfqqrwgylpkz9jaAHaNwBidDFGbHCTfK5yp/l4rgDpfntNhp3Fy+eHHFyFpWNupbMmN713wdI/gpyCbSkgkYw7Z1OdtqDGjQuoF62ZzjozXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715089547; c=relaxed/simple;
	bh=xxnhas2cb/yYg45I3+N1ICf2+Vpw3ziwOEY0V2QR1n8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iscO5gAoJBw7zmzmeIXyQRyV95Fln3uF6zc9Hr575Ux+R1bCDnBIgkfhoUPEHOZPx9l+4xrin2H97xhhJnExXuDoQMcdYb3/CTrIYCs4pdDxzABN/OzQKCwlRf4c2SSR4eYkRXkN/Kn7A5TYehpM3cb3zQJLFpoC9QtGlOq4LVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=keVULDMX; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1715089521; x=1715694321; i=markus.elfring@web.de;
	bh=3px9/RbxccAcsYKylpIY+Fn+bv8EDMFZx9CbArtpbqg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=keVULDMXuQtB+hrE6Btms5CjrqubYvl1czl/fb+xbQ7TnVzyVl/CWPPHZrzXUA1M
	 gb7vXkPFQobiJyg3Ye7AbDV7vKN9tCfuxk5uNAjP1kft7oi7kJmGHe5247cDo8pl/
	 ivvVogJF9pxFrIcwm7eda9aiCCHJl8Lcoibmt1EgXTzA+QRdAvmv0fmNJv3HZXm+T
	 RYGl92iGJwOCVydJhEWuMkpbCW+6wXTXHi498Exh9xrmYxbiZZy7NlAzkttFo65nR
	 nqOUQJYd9NBR1i1r0oqcR3bxdkkSbxDNErmLcLgNxTsRAIGAfjYTS2nNp2PQVZ7AX
	 UUSNNuOO6NSoOsWF7w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.89.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N1d7i-1skJlR27zM-0124Dg; Tue, 07
 May 2024 15:45:21 +0200
Message-ID: <c4ff2987-df22-4338-8a78-5efa2c7c23d6@web.de>
Date: Tue, 7 May 2024 15:45:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] LoongArch: KVM: Add PMU support
To: Song Gao <gaosong@loongson.cn>, loongarch@lists.linux.dev,
 kernel-janitors@vger.kernel.org, maobibo@loongson.cn
Cc: LKML <linux-kernel@vger.kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Tianrui Zhao <zhaotianrui@loongson.cn>,
 Wang Xuerui <kernel@xen0n.name>
References: <20240507120140.3119714-1-gaosong@loongson.cn>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240507120140.3119714-1-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:75tpmQO1YYP32lrES5yd7ri9uPgTkzgd97BeRLmVyyfN67mXF6q
 V4q5qC3PwUIcmy6KD3qVNnLN1fNq5EeBSB/vbd6x9bZ0SEVpNP/tzlUEny48D6iRxVODyRA
 8LR906/ZDw+6WnDWJDaylPbV84K2zZUOWQ6k3EdGLqtEBi33PJBtYNLCIRd+U9oOQfHu4cp
 LowpT5Z7j+wBawejpoyJg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:HrrQzl1torE=;d1u8OZYjQwxv6OniYQGvOisWT4c
 bcw/1xN7lwSdJSkEG4QG9VK5QoNTjfL2iOVaEu1JCUY/lIdFAFOKcGNguv/U9NKobHxw2GdAu
 AIQ50aLUgQFX6CppxhCnTVhiVSASsreES/OH/5I+u6L0EmLmBKJQ05VG8CXg96JpL/gzxiWWq
 Ioq1x3O8qpBM5//6jbRE1MOiHQNeJfgL+vgyEZuaA8Zh4spPnAaupF3CG7hF110zr7egsuWGQ
 WqzplzgZJqAUEbkgzmYCvgA0h4g6Yp27jQKoYbunBaNiGzvKHx2yNg5Kom2s5Bo4cUtRPnoen
 6ZHTQ5bryaj/POEoZAgzFHmO5k9NIBvDCVAusJZNWZHcnVJhT7zlxECLf0feEzodfL9F325MG
 JybzqQ0NcCBUYMh8HWGk8KNCcUq+EfAO/j3GsphZcFsMvNNMKhdXpy+mbeJqGvdBgELvoowyL
 ioyo0r2D4G+kOj4DWLi//Vhtx2Ymc4HJIDc2JtBkJ0K7UPv0tZAKNjtsUb6M3HqYGDPrdxc2Y
 xlvEcn7ZFydQEv+N2kgkGx4TsvsLIDnzJIQfm9jqVq86xUo5ml5UsLxUFIzdbYstxZ6KKxoZZ
 e4efy1lzEErPCujfug1OcdACxWxrNXGCCFJiEPXERIQFeIMYVj9f6pHgg7UcSB2Lgc5rngAnr
 zf1yaocYWTarY+G+MjDef+/1+fJ55Hn0pWQ/eqMMH/+aI/s79Q1c0j6y5VEK4Ca2RzaUOolIS
 xHiJi6YpqHfxs5s8hGlHj8aUSwQ6xZBer7qDRMuRY8pBwuEUPX/M93YyOr9VC1b1jzlwE3Qyj
 ObsH7AbS7JIsGjGpAa8lTyDb2aNJTwusq2vaVFLH4gb8Y=

=E2=80=A6
> - we save the host PMU CSRs into structure kvm_context.
> - If the host supports the PMU feature.
>   - When entering guest mode. we save the host PMU CSRs and restore the =
guest PMU CSRs.
>   - When exiting guest mode, we save the guest PMU CSRs and restore the =
host PMU CSRs.

How do you think about to use imperative wordings for improved change desc=
riptions?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.9-rc7#n94

Would you like to take another look at the usage of dots and commas
in such a changelog?

Regards,
Markus

