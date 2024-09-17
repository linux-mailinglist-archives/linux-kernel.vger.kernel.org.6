Return-Path: <linux-kernel+bounces-331352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02FE797ABAF
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 08:53:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C829D289E76
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 06:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2BD7DA91;
	Tue, 17 Sep 2024 06:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="dGdduibi"
Received: from pv50p00im-ztdg10012101.me.com (pv50p00im-ztdg10012101.me.com [17.58.6.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A41C1C28E
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 06:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726556024; cv=none; b=QxAd//H/1TSvWBN3hTrONOKK+YVHa8RFpAYiZBbclBIEVGnlWU6oCDD+6GPqsuu3JRuIn9oUePeMiPyk0yUY1faNNphwUX614s+A9HV0+2BTm4bL0U8Hw4S39wndXHi1/xsJfD1saIU/IQkc83u9li2Fg8tzPfWqvL2kGqmUFO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726556024; c=relaxed/simple;
	bh=7SDt+6Vn3bNs2crOFQB5j3+BamupUACjNlALbh+L3gw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EnoSpibrKCcAMNeQgdiS60/k7jfMUQOMLljJW+bvN+BSNGvSZ+co30BciDFoeI0s5EFPMcyN35ZuFNQHoI8yHkO0AN4rMU9Mxysqhu2KtJhNgb/+se7qWq+Sa9p04fRePXVvuEcaJX2Wha5m16cJ9o6FVN/vUo3H7LTXlI/hmG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=dGdduibi; arc=none smtp.client-ip=17.58.6.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1726556022;
	bh=CoMlNrXWs+gGJBLPTk/xVawkaKHJAdc8hL5lXf0MrC4=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	b=dGdduibiqBK6iWWarrHDcUhqS9E/yXvybIKoXDTYC+X/KXIPl4psWSmMf0j+OkAIJ
	 6FWaJF56KbsVIDXS/ecV0xYn4cTKxlof95PaFTlYmA2M7/dc0SPivuDYLNdzAku+Fu
	 TSBxpA4hq6xcRwct/if9XKz7ueVQQW7NqVTjvBIyuG6j79G3RhoEkgvpkNGphr9CEm
	 LDWUvuphFtwaolxVu9jhwaGKPHUl9X1Q8cz+EeFuxUIxtWsnCu5klhjsI22Rd8pted
	 JBqXZl4EvuP2hcf6LtaS2A5c9IZaoLQstSlAsG+z2dmIWFSbhieO3/ocWtPYlxfj6M
	 A1p4WU/GL8Elg==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10012101.me.com (Postfix) with ESMTPSA id 7A0F7740512;
	Tue, 17 Sep 2024 06:53:37 +0000 (UTC)
Message-ID: <420b202e-e094-4e82-bf77-dd1c62119aa7@icloud.com>
Date: Tue, 17 Sep 2024 14:53:32 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] driver core: bus: Remove an impossible error handling
 path in bus_add_driver()
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
References: <20240917-bus_add_driver_fix-v2-1-a94026443444@quicinc.com>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <20240917-bus_add_driver_fix-v2-1-a94026443444@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: sHjjPLYcPWPupi8LfiLZoRC19vCZ6ilK
X-Proofpoint-GUID: sHjjPLYcPWPupi8LfiLZoRC19vCZ6ilK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-17_02,2024-09-16_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 clxscore=1015 adultscore=0 malwarescore=0 mlxscore=0 phishscore=0
 spamscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2409170050

On 2024/9/17 14:49, Zijun Hu wrote:
> From: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> For the following function call chain:
> API driver_register() -> bus_add_driver() -> driver_attach()
> 
> There is an error handling path for driver_attach() returning non-zero
> or failure in bus_add_driver(), remove it with below reasons:
> 
> - It is impossible for driver_attach() to have failure in bus_add_driver()
>   For int driver_attach(const struct device_driver *drv), the only factor
>   which makes it failed is that bus_to_subsys(@drv->bus) is NULL, but
>   the factor has been excluded by bus_add_driver() before calling it.
> 
> - driver_attach() is irrelevant with driver_register(), so the former's
>   result should not also have an impact on the later.
> 
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> ---
> Changes in v2:
> - Remove the error handling path instead of WARN_ON() it.
> - Correct title and commit message
> - Link to v1: https://lore.kernel.org/r/20240915-bus_add_driver_fix-v1-1-ce5cf1f66601@quicinc.com
> ---
>  drivers/base/bus.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/base/bus.c b/drivers/base/bus.c
> index 657c93c38b0d..54ff92aece92 100644
> --- a/drivers/base/bus.c
> +++ b/drivers/base/bus.c
> @@ -674,7 +674,8 @@ int bus_add_driver(struct device_driver *drv)
>  	if (sp->drivers_autoprobe) {
>  		error = driver_attach(drv);
>  		if (error)
> -			goto out_del_list;
> +			pr_warn("%s: failed to attach driver '%s' to bus '%s'\n",
> +				__func__, drv->name, sp->bus->name);

driver_attach() has __must_check attribute and this error may be
inconsequential for driver_register(), so give pr_warn() here

>  	}
>  	error = module_add_driver(drv->owner, drv);
>  	if (error) {
> @@ -708,7 +709,6 @@ int bus_add_driver(struct device_driver *drv)
>  
>  out_detach:
>  	driver_detach(drv);
> -out_del_list:
>  	klist_del(&priv->knode_bus);
>  out_unregister:
>  	kobject_put(&priv->kobj);
> 
> ---
> base-commit: 6a36d828bdef0e02b1e6c12e2160f5b83be6aab5
> change-id: 20240915-bus_add_driver_fix-f54841e6a69a
> 
> Best regards,


