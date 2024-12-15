Return-Path: <linux-kernel+bounces-446502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5BB59F2523
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 18:47:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 186801648C6
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 17:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A4F1B4157;
	Sun, 15 Dec 2024 17:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VF8NOEru"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C301119A;
	Sun, 15 Dec 2024 17:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734284815; cv=none; b=Mm+1QXWHRVNmwB78UrA1hrAmrY/VN21Kuj24UHueaS2fcojG8sjfVc12zLh74c+jEJIHPN9LpbjZM9p5M9JiKPMm39xVv/FL0A1q3LS8LTd43D/zMoPymmf34kUQlznGkPv+hiXeEjRg4YkHsR3pJKLkmIW8/QipdRIaPQ/5T9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734284815; c=relaxed/simple;
	bh=P+D5NOuscZiwdPVJ/Fz1S/W7kfcMJ8SsQQwV7AfKeFg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kYE81t+v0qEspl3VRblQ0CHqeZtthHwADWrilNlortc929jyTj5BcEl7Vp5YkrkOX1Z+NBgNe2l2h9To3QiTIEHp71woowA2pus0qQCqkXr3mUECh+z0xjgPs0Jv4FvvJVzvSXxyCgOaXl02vptC31cEaQxM5Rd4DWs+DsXsoeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VF8NOEru; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=9OY8ueUm4CR5UDIgHGg7Qyv//mhOC72otISc2Hlc4wM=; b=VF8NOErupEGkx3Efz/1IfnM2ay
	zmE5nMaIDXsHEe/YPuWnrjRJAMDFgBPwVI83IANd2/iDwMfUtrxW222pyMuAJKUGh3wwcTzUNzdvP
	XoGghKYtwf9+d+GvAbzJyQ1z66IR6hZz+cnx7191tRIM4i96drl7L9Y+njl6VhgBOJISmV6wSjXi9
	ZErRab9/aryHDkvY1alrD//cF6QxKLNublQJr3q0M2hAj/UJMMu0kTJJbFthdZhGGxni5iYnK3QuX
	NIXE3vIkNM/xmlpDUcZQXSUtLYK7fNnz0viu+rnT+EJIeGFXaxyH51Iea5SYOohm6yAi3TEAD9dzA
	aEQrQn+g==;
Received: from [50.53.2.24] (helo=[192.168.254.17])
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tMrrn-00000004iKt-2pj8;
	Sun, 15 Dec 2024 16:53:16 +0000
Message-ID: <d9f04bf6-18a0-4f6b-a6ff-2c6e493005e3@infradead.org>
Date: Sun, 15 Dec 2024 08:53:09 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86: samsung-galaxybook: Add samsung-galaxybook
 driver
To: Joshua Grisham <josh@joshuagrisham.com>
Cc: ilpo.jarvinen@linux.intel.com, hdegoede@redhat.com,
 platform-driver-x86@vger.kernel.org, corbet@lwn.net,
 linux-doc@vger.kernel.org, jdelvare@suse.com, linux@roeck-us.net,
 linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241209163720.17597-1-josh@joshuagrisham.com>
 <797b248c-7542-43fd-8e44-f2c7d650ccff@infradead.org>
 <CAMF+Keb0cXc8t8J_T39WJUKydpD2EME92ZWT7SFr_taiCXfvww@mail.gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CAMF+Keb0cXc8t8J_T39WJUKydpD2EME92ZWT7SFr_taiCXfvww@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 12/15/24 8:09 AM, Joshua Grisham wrote:
> Den mån 9 dec. 2024 kl 18:04 skrev Randy Dunlap <rdunlap@infradead.org>:
>>
>> Also needs <linux/sysfs.h>.
>> Maybe <linux/printk.h>.
>> Maybe <linux/err.h>.
>>
>> --
>> ~Randy
>>
> 
> Also done in v2 of the patch, thanks Randy! (though no printk.h
> anymore as I removed all pr_* functions.. maybe I should explicitly
> add <linux/dev_printk.h> though? or is it good enough to get it via
> platform_device.h <= device.h <= dev_printk.h  ?)
> 
> Joshua

from Documentation/process/submit-checklist.rst:

1) If you use a facility then #include the file that defines/declares
   that facility.  Don't depend on other header files pulling in ones
   that you use.


-- 
~Randy


