Return-Path: <linux-kernel+bounces-438081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 736DD9E9C97
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 18:06:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04062188766B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 17:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B7EB1E9B26;
	Mon,  9 Dec 2024 17:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hrBYL1qq"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6D215530C;
	Mon,  9 Dec 2024 17:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733763831; cv=none; b=bRoAtUbIiQQ7EFP6jKSHR9kJ7oyXbw1TPP5Jgb6qqUbYF13meGW9ZOy06WUVNzaTswj9bMo+T3ecFEcuICsz8/ezWgsYV/SOn2/Gl0qlP8YpIcPuIdllyCsSC53KWm3QJeh8B1edhcmyN7DBhExN6taku4RFwbNO4xr8Ee5FMME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733763831; c=relaxed/simple;
	bh=eCMWgFvbY4ns5zSok5JYsROPq73qLAkUJUay0CVu7Sg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OewrW5V7gPHbZvlbzygy71WlEJ1eQOFT+R6blBQEUR7qUFTdja8ta2yjkuJzanqt6bwsXY+sVn/etRb2VrJ0CoVxPegLXIdYoFPqOFrTvyjJ5Vqom3PHcZIB/ipNkrBECt81OdimZEkcfjI/fLCXYVyuCuK9uBiWB3A4SLQJ3VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hrBYL1qq; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description;
	bh=dodVvb49ehuC32Bl46Qmy2WJtql+F+dXrZFPNv1EKho=; b=hrBYL1qq2k84d3jEg4po5hKm1v
	HUYjOKpWPZknmIpAFZczWUHZEUnlmqYcR8IqfcIZFjhEBY8MMAdt1qohkIFRKfwB/QCcG7uifpL1I
	CecYlFVi+pykaxbYfQMB0Gbm2Ti+hyksWmT53ZtCdXXaTDrN9dRriex7vsT+X2Zi6sEhjvOosy8ft
	dOCAOF2Gi4VofrxfpxuQ1ZdRc/SBy0VegIbTjTWVLd1jRrjOlBCybbxuiLdX4Qzmn1sBXgoInczv9
	eKCaxhTYttLVHytyhELeZTdAB3xcRHkKsYGDwYuczUj7O/a2nVTQBmIbwcnShoSkhsXNyy6JDfjMo
	urbSWinw==;
Received: from [50.53.2.24] (helo=[192.168.254.17])
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tKhAc-00000003Yd4-39Gl;
	Mon, 09 Dec 2024 17:03:43 +0000
Message-ID: <797b248c-7542-43fd-8e44-f2c7d650ccff@infradead.org>
Date: Mon, 9 Dec 2024 09:03:36 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86: samsung-galaxybook: Add samsung-galaxybook
 driver
To: Joshua Grisham <josh@joshuagrisham.com>, ilpo.jarvinen@linux.intel.com,
 hdegoede@redhat.com, platform-driver-x86@vger.kernel.org, corbet@lwn.net,
 linux-doc@vger.kernel.org, jdelvare@suse.com, linux@roeck-us.net,
 linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241209163720.17597-1-josh@joshuagrisham.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20241209163720.17597-1-josh@joshuagrisham.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 12/9/24 8:37 AM, Joshua Grisham wrote:
> +#include <linux/acpi.h>
> +#include <linux/dmi.h>
> +#include <linux/hwmon.h>
> +#include <linux/i8042.h>
> +#include <linux/init.h>
> +#include <linux/input.h>
> +#include <linux/input/sparse-keymap.h>
> +#include <linux/kernel.h>
> +#include <linux/leds.h>
> +#include <linux/module.h>
> +#include <linux/moduleparam.h>
> +#include <linux/nls.h>
> +#include <linux/platform_device.h>
> +#include <linux/platform_profile.h>
> +#include <linux/serio.h>
> +#include <linux/workqueue.h>
> +#include <acpi/battery.h>

Also needs <linux/sysfs.h>.
Maybe <linux/printk.h>.
Maybe <linux/err.h>.

-- 
~Randy


