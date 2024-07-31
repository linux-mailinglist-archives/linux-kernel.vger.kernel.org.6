Return-Path: <linux-kernel+bounces-268552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A09B94261E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 08:05:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B71D91F21E3D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 06:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B7A130E4A;
	Wed, 31 Jul 2024 06:05:42 +0000 (UTC)
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6538086AFA;
	Wed, 31 Jul 2024 06:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722405941; cv=none; b=kEkRNKHnU7ouFMSp1BJM6yIt1aEwLw5EjPf2iXDPDa/1MA22ehMKjdZsk9k5JN4A3m08KqjIoK/8wpu26x1TmFqW9NoVVQtPmAhwHSpmAWq+5w/XHDy0RoJrvlI8CpWqIaE94475USYRECtQRlDkRdH3VclIN4/k/5WrnQWiqo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722405941; c=relaxed/simple;
	bh=Jfb32fmoRBah5K/TRzqKuphLtVvEUwuBjg8gll079nM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yj9E2Hz4S2wMwZn7sMyxOloUXoTXXfrhxoRJjCctE1vS5Yd4dPstuihiAIiRDpUugP4Kyh3Py+3ptx+FXlq+kCK1MtffoEnQ1zTeAy83sLasL4EjN96+0I2PujGKhg3YYCun9a6xqlsrgn2CF7UDNO/OUwlvQNW8foo4sL5BWA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
X-QQ-mid: bizesmtpsz5t1722405905t75b0b9
X-QQ-Originating-IP: L8zPWYoYF9HeaiXZZoV5vVP/gC34wDkDtF9OHuW+rCU=
Received: from [10.20.53.89] ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 31 Jul 2024 14:05:03 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 9183415464002977856
Message-ID: <922714F826930E40+48e8f174-ed9d-4fc6-8227-28bdfff0fda2@uniontech.com>
Date: Wed, 31 Jul 2024 14:05:03 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: Loongarch: Remove undefined a6 argument comment for
 kvm_hypercall
To: Dandan Zhang <zhangdandan@uniontech.com>, zhaotianrui@loongson.cn,
 maobibo@loongson.cn, chenhuacai@kernel.org, kernel@xen0n.name
Cc: kvm@vger.kernel.org, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org, Wentao Guan <guanwentao@uniontech.com>
References: <6D5128458C9E19E4+20240725134820.55817-1-zhangdandan@uniontech.com>
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
In-Reply-To: <6D5128458C9E19E4+20240725134820.55817-1-zhangdandan@uniontech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1

Hi all,


The English documentation for LoongArch KVM has been submitted.


Link: 
https://lore.kernel.org/all/04DAF94279B88A3F+20240731055755.84082-1-wangyuli@uniontech.com/

To ensure consistency,I have observed that a complete Chinese

translation of the KVM subsystem is currently absent from the kernel.


Consequently,I will undertake the translation of the entire subsystem

prior to incorporating the LoongArch KVM-specific documentation.


This process may require some time,but I will endeavor to complete

it as expeditiously as possible.


Best wishes,

-- 
WangYuli*
*


