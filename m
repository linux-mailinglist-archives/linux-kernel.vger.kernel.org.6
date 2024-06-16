Return-Path: <linux-kernel+bounces-216431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C0D909F38
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 20:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7436B20F77
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 18:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 545F441A8F;
	Sun, 16 Jun 2024 18:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="qI1As9Ll"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244D949628;
	Sun, 16 Jun 2024 18:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718562914; cv=none; b=HWx8maAAKXt/KTI1A1NHfiskNrxt/Y/ZYub0KXPXyQUxw2RB6u1rRIBA2EQpfCNMy4BhHkcSXrDpKZNLnWP/vI7B672s0WdRnWRKRKgpTr9Lq3GgIl/ee/h/sc4nLCDuN63lX+Z02jez1cTpN1hb7+WubrRe7+0elMmC99+Z6FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718562914; c=relaxed/simple;
	bh=HeaXwg9XsZN4AFWulu71KeS/rFUqgBiwU0nfkKkuwfk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=rRTeyaZPgYSYZhp4DZS+PmiaFZ4Kbq5q7aHMSLu3vgzKeOyZMTQC8QKUGKHIQ1CqsEFBNbaGLHgkOTcnBBI8EQIcX2HBJGYKuf7hYXO4eNwaz/f3p4be4tlawup8BVtfTOziZ7WyIQvXUG4InGpvI01pFxr/pOKeJcgR1DcwpDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=qI1As9Ll; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1718562903; x=1719167703; i=w_armin@gmx.de;
	bh=8cMcCHyj7SK1ospdikUHJVnpM8ILHd4al8fLJol3GzM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=qI1As9Ll1/tvRbTZgJdnuFPbLtfiE85bOr/OkZqTc/LbifX3QPVSm6q+VwLIj1wr
	 41X0hG2+67JUItVy5T36o8kEMIPZIv09reGsdVe3WbiQpRBtBHyPRluM/GU2jmDmC
	 YmbdcBEg8d9hQPXJaWyICv7kWkD6GPlex+i3KfPEz1ElyD1WXrrFrvgRS8ZGpFaWR
	 V+ytyvZtBo3nvsUsyO7YiefrvtedzLTcs2FApjC5bwZUWhiyROCJeo2PgL9g3qQl/
	 nnusFXUBYt/CeidynlqQshzdJa8bMm7XlK1lt15gnRM57Vj8qf2yGPhslHRpADYdO
	 +958YmJwNPiacC/DkA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N7QxB-1sShuE2tHJ-00rjtI; Sun, 16
 Jun 2024 20:35:03 +0200
Message-ID: <0f361860-01d7-4f41-8b15-f616c652ec32@gmx.de>
Date: Sun, 16 Jun 2024 20:35:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] platform/x86: lg-laptop: Support 2024 models
From: Armin Wolf <W_Armin@gmx.de>
To: matan@svgalib.org, agathe@boutmy.com
Cc: hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240606233540.9774-1-W_Armin@gmx.de>
Content-Language: en-US
In-Reply-To: <20240606233540.9774-1-W_Armin@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:iubwjF+P7X7lTi41OuA+3Xk8Q7BpBTy5Qb47VqXIZR4DRGgzRBz
 qBaMv4qjU/+2XCB11o1YGrOx5UoGzTbDXtpb5/YvYh72XsMERDqHufni+AiEEeX1BKOGqXh
 8d/uMQNsjxW35koebJaQ23jJyVO3JPxLfW5YDdR7IHwqan+MYpa9KRr+gAh84rm0F9yWJKM
 HPoQ8GGegphUynKGaIXYA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:8ZikU1DsVqY=;adJA1e9rr04wzH107dSje/v3rkb
 KTuvX/sGkuyqwpTl9cdEAOf44dRRIT5VpdrCEdkEElFozpfXsWVPKCTA5n7SHNeaxng2dIlCe
 vK7BUlJbJjdBbpTXTN5BOFINE0fDogH9kNCTp79JsO4rE3gybp0kh4x20kNnZ8urztxIYXv+l
 mj7cp82lZXgzPDV27ZlwqMVBpjd6NebwmbcdaHNwcyJ0s7WvBR0YYAkVhwIMYLhvCNDUnbmbk
 M7WOtD0ioeE/MivyMGFeqv5nvmuUJFp7x271XlIBou6xjXo9p+L0sU0SjEh7lj3/AyW5iDtS/
 0jYyhhZi44lFFPgbsXQVGDqLMfPq6hHnoK4rL/OW398+lqURCI2c61FADJJSbvvSKvcIAzVWr
 bDR2Yc/O3ra8Q8EQeWDws+0EtKSQHGQB/NdvojexBwpJ6yVk5UgwTnxuTQMW4qWCKS+EAyYla
 1pnJFvcQNyb4sG02bFtODlzyqsxSNdvQgo5DITDCLkxRStLHxBwg7QaUrHHLObvm6EfD9+LSr
 ami1GExTsTdAwqZXsvFkxuTAZSOFAnaoq9ZOuy4tf57ef48T+XefUcRe/UFcimUnpNlZlHon+
 8uXVbgl2s1+8/vh/oTAHt1xKh3eLntc+yC059c3075WkXpF2K2LMBh7BgNZsHsPqSMbhvllMW
 4NoF08VkZyJvA8fQtReXEV82ndaL5R22Pl0Wb9Tm/h04tzrilChne3NDKRD5vt1TfX5y1xsxn
 C1gzgq5xXTyPYGGVm2Z6Uu4HpTFOwS4mJ4QLIXiLiYoibuWMUBMqfJKznMi2PCFoiZBA4sF/y
 JAn7aFJ6c8xWgr8wzjnnztHTT89/rAenf23RL95vYW5bw=

Am 07.06.24 um 01:35 schrieb Armin Wolf:

> A user complained that the lg-laptop driver does not work on 2024
> models like the LG Gram 16Z90S-G.AD7BF. The underlying reason turned
> out to be that the ACPI methods used by this driver where not mapped
> under \XINI, but instead under \_SB.XINI. Those ACPI methods are
> associated with the LGEX0820 ACPI device, which was not used by this
> driver until now.
>
> The first three patches move the airplane mode hotkey handling out
> of lg-laptop and into the wireless-hotkey driver. This necessary
> because the airplane mode hotkey is handled by a different ACPI
> device (LGEX0815).
>
> The last patch finally fixes the underlying issue and uses the
> LGEX0820 ACPI device to find theWMAB/WMBB ACPI methods.
>
> The modified drivers where tested by the user which created the
> bug report and appear to work without issues.

Hi,

any thought from the maintainer of the driver perhaps?

Thanks,
Armin Wolf

> Armin Wolf (4):
>    platform/x86: wireless-hotkey: Add support for LG Airplane Button
>    platform/x86: lg-laptop: Remove LGEX0815 hotkey handling
>    platform/x86: lg-laptop: Change ACPI device id
>    platform/x86: lg-laptop: Use ACPI device handle when evaluating
>      WMAB/WMBB
>
>   drivers/platform/x86/lg-laptop.c       | 89 ++++++++++----------------
>   drivers/platform/x86/wireless-hotkey.c |  2 +
>   2 files changed, 36 insertions(+), 55 deletions(-)
>
> --
> 2.39.2
>
>

