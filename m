Return-Path: <linux-kernel+bounces-243134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E33D92924C
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 11:46:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5E162830A9
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 09:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB6BE4D5BD;
	Sat,  6 Jul 2024 09:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="KXKdmgl+"
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889A1DF6C;
	Sat,  6 Jul 2024 09:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720259198; cv=none; b=ctSlMWJdUfnuQ2te4cy0MmghrPy8ENt9wjOI4pbcMxFpslj2O/zTuZDHdKQz4KFPBj0SrEskQYYF9cpkb3AwXf/Zu1UAuk72xI35XKJuE3ga4jH3tvIJwcBp/XFZ5m7hIrYFUYStZp3frAMEDZEwhL9t84qcyl5rLCD7qF3qWcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720259198; c=relaxed/simple;
	bh=QnGcOl9oXoeopuI5Udmk0RgExWQN/v3kgP7QbQETryE=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=uEdOoug+JrPy12vF+Rcj/TtRkG7j/QYkkSMWkrLFur7AxpVJ6wXI/VRV7YI0hIHX875nvAXvswB65k0aaH/mEVi+YXiYgr1XZJl0U7AbHKptGZBsNez5CI3QddS8lwI0uRU/IMvQejsockXyreSWMHZn05JRE7EfyCC9oZxzCUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=KXKdmgl+; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1720259098; x=1720863898; i=markus.elfring@web.de;
	bh=ZUBSXMP3zCePbXBrp/yGxgf8fIuR0VVp7H9msICP90U=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=KXKdmgl+TKIPDoYTraWvhyrqLaakhxklOgMCuJInmaAKj7pjYGXc5V2hxXO+xyjh
	 6majvpiox2Q7ZD3CqJY2gABjEVtPWSxZGRsKrY555mhsGSokHi8FC1WW29NEdbGz2
	 yFhEAaifKNeQ6IwB41Hphgp4HbeexKblHK+Z/iFXKxKGqtwr2oU2UhCY3QdLujy1u
	 V89Qu3iOv+rDvZSYSsZyuxV5VDAvFzozoZuVTllUt2A4E9P7LftPMSZwoXkhzD6ex
	 CFzxi02nkJ4Ru7P5rgWOn4JWHMOG/9F9ZJUsCFBoghxWhtybxkJ3roelYXjmGGDrC
	 qMszOF+1eCRd+ZSYMQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MnX1L-1s0dSO3qOT-00cVet; Sat, 06
 Jul 2024 11:44:57 +0200
Message-ID: <2b0c7d74-8a20-4a54-9467-bec4395a203e@web.de>
Date: Sat, 6 Jul 2024 11:44:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Xi Ruoyao <xry111@xry111.site>, loongarch@lists.linux.dev,
 llvm@lists.linux.dev, Huacai Chen <chenhuacai@kernel.org>,
 Wang Xuerui <kernel@xen0n.name>
Cc: LKML <linux-kernel@vger.kernel.org>, Fangrui Song <maskray@google.com>,
 Jinyang He <hejinyang@loongson.cn>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Tiezhu Yang <yangtiezhu@loongson.cn>, Youling Tang <tangyouling@kylinos.cn>
References: <20240706073858.161035-1-xry111@xry111.site>
Subject: Re: [PATCH 1/2] LoongArch: Remove a redundant checking in relocator
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240706073858.161035-1-xry111@xry111.site>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:El3xGddA3OmLZNBG8qQpEg+y947RSqGdyNGexujx06XBdUcOesj
 IJzhW1nW++qs0YBHy1Yj5xmwUl/sJQqG7IMtuoI6pKvmwRunoudCVLuAOvuBHPexALMGKzz
 m3NuxdHcjlxB2vNCCvVatGnCPKlgqVXGKGB7VrhADMfBZu3RHByprRkgQTX9v3DZVHFjPLG
 CVUL3Ogb3h3blSM7EqyAw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:aqTKmKEGH6g=;r8IP2hz+nCTPUyZGLUrShQKycOb
 o6uuMPbQw5VqwyVEGbic+SQ0j8S+Zj/kAsRuHK+J/+7VTcLrgiLFkbMKaiuF6gsPcO2SJYp5q
 jV4dVK153FdLtS6yGd8/Fmw0A6s9674e4uoqkAzZSgEecdUFwVHqv0ivWGp0kDxIVVkwAPpcy
 KyuUF/2T2ZJTgy+OjYfJQQaavC0V8O2W9Zbg0+eJli/+/SLlV0jM132MnsxSZ887KPmSrEiL/
 /qEJjpY4fmaDiP054CbaOT3gYhayY79zRitv+WHzRrEvZdjWwQlBBzutzOslJakSRAvVn7IvE
 9qrm8LhqSnu11LAHUt6RJY0kH94C7M7iepwTX8tsO7Ds9knjvSVacxv3uaS1EKhGZZG0PyCI/
 hOC6Ya0Pdlhcxfqt9q6NovgBLr+Jql/M9VTVV/NXaLkDiy1APkZe8lI3UMLcUMIzGfemddhB8
 x2cXoiftLNpXHv4fp3MgA2TrXiFiiTxSvVzPuzvGKlY3A3skVIbteie8fD2Sx0Xf2axgPixaw
 W69GzQA350TpARNo+q3vo6EWlguzb+/a7+PKhfGpDCREGfTD7mDLssK3MK4Kf9zN9Lb/R/a3P
 TC+Ww1yCRwNgymeeRbkdqEkd2Ip5m9pyli+g3OhK6cDB3tcqz0dTMQUkfBfDVyTUxhpT4C6ky
 H41nLjSPfBpIQeg9Vwv0jlZizd2KFZegycb9Pnqjf7fiZZzVjWuqs0Zcw9/+YpaI7Q+jloiXi
 fa2hJW8Ka7Hz0sTXJLhiH3PyNNlMJfnGQCDzthlblFrHE+Fl9qFQc0G/DEQ+7Od+1L5y6VMem
 /MnQOpxN/HcCk9evZ93YNkTcznQ7RW8RiYo2kRaVnfzKY=

> With our linker script "relocated_addr >= VMLINUX_LOAD_ADDRESS" should
> be always true.

* I find cover letters helpful for patch series.

* Under which circumstances would you care more for remaining patch review concerns
  also according to better change descriptions (or changelogs)?
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.10-rc6#n94


Regards,
Markus

