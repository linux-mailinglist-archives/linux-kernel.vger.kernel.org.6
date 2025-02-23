Return-Path: <linux-kernel+bounces-527581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E39A40CD7
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 06:32:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 118F617BF95
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 05:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E6011B2182;
	Sun, 23 Feb 2025 05:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="G/HqlDrL"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B36B64A;
	Sun, 23 Feb 2025 05:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740288719; cv=none; b=LeHapN3R8m1FzBBDxiwGRXM9nF8PGvSkLRXNIuQkndDm6lbLlhlEa+pEIJJOevQtBBep/ALbuU1xIIBRriaUjKoVJuxpDN0COIVDsiDT+RngRP7EbcuEmkCHg4THufNZbrlYj8hcp0mjMrdsYn6MkpTLqv+5aa98mMWMRgxzeao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740288719; c=relaxed/simple;
	bh=vQEE+ALA8+X2nmKLCIo6hihuAO4bZj34XMzDPEDCe5g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kdNdxmHgBHe7IRpP3UZBBRiCUnVEJGgzOe19Yy0YfDpWkzoTZxeQaWVT0KiqEkR8q0a1Kf/Crd4hlUlc8ELVuPIubwX1bFpWSPTqfExy42KgqyqvrNd739iYHxnLTSyEJkr3ndcNFy5H7JVFtxJ2r3whe7LHAagkuk1fihvW3KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=G/HqlDrL; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=lFjRKICRGEf1Ot0OXpxrVo8Wu4CzLQ6I016czoi9BtY=;
	b=G/HqlDrLGDxHsca9zWPhCk6uJXAJsVJM3wRGhHju+l5Bg2mHuX+Fbv1ki0jabs
	hY0xqN9xDH+2EJpEd9tliDedfJOzxwbgx26Spp5JqczVz3Cw5pRuBsMgVpmaZ2Tm
	loja4jte8udasei2ztUSfQshP3NUno0pv8xM5mu5zRt48=
Received: from [192.168.71.44] (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wD3H_eJsrpnxfn8NQ--.51161S2;
	Sun, 23 Feb 2025 13:30:50 +0800 (CST)
Message-ID: <3b540c87-1d55-4289-b347-6bc2da49f407@163.com>
Date: Sun, 23 Feb 2025 13:30:48 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v4] PCI: dwc: Add the debugfs property to provide the LTSSM
 status of the PCIe link
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: jingoohan1@gmail.com, shradha.t@samsung.com, lpieralisi@kernel.org,
 kw@linux.com, robh@kernel.org, bhelgaas@google.com, Frank.Li@nxp.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 rockswang7@gmail.com, Niklas Cassel <cassel@kernel.org>
References: <20250222143335.221168-1-18255117159@163.com>
 <20250222163909.mmjvnlsituqrrocf@thinkpad>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <20250222163909.mmjvnlsituqrrocf@thinkpad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wD3H_eJsrpnxfn8NQ--.51161S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Wr4rWFy8Ww45CrykXr43Jrb_yoWDWFXE9r
	Wjy393AFy3JFs8AF90k34fXr9rX3s7Wr17KrnFg34Fqa4DXF43GFykArWxZFWxG3WkWrnI
	yry3GFW5KryDZjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbkpnPUUUUU==
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbBDwT8o2e6o8LmawAAsl



On 2025/2/23 00:39, Manivannan Sadhasivam wrote:
>> +
>> +What:		/sys/kernel/debug/dwc_pcie_<dev>/ltssm_status
>> +Date:		February 2025
>> +Contact:	Hans Zhang <18255117159@163.com>
>> +Description:	(RO) Read will return the current value of the PCIe link status raw value and
>> +		string status.
> 
> 'Read will return the current PCIe LTSSM state in both string and raw value.'
> 
>>   
>> +char *dw_ltssm_sts_string(enum dw_pcie_ltssm ltssm)
> 
> const char *dw_pcie_ltssm_string()
> 
>> +{
>> +	char *str;
> 
> const char *
> 
>> +
>> +	switch (ltssm) {
>> +#define DW_PCIE_LTSSM_NAME(n) case n: str = #n; break
>> @@ -683,6 +714,8 @@ static inline enum dw_pcie_ltssm dw_pcie_get_ltssm(struct dw_pcie *pci)
>>   	return (enum dw_pcie_ltssm)FIELD_GET(PORT_LOGIC_LTSSM_STATE_MASK, val);
>>   }
>>   
>> +char *dw_ltssm_sts_string(enum dw_pcie_ltssm ltssm);
> 
> const char *dw_pcie_ltssm_string()

These recommendations will be changed in the next version.

Thank you very much Mani.

Best regards
Hans


