Return-Path: <linux-kernel+bounces-569760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CCC5A6A72B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 14:29:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 168B6983798
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 13:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 617AF21CA00;
	Thu, 20 Mar 2025 13:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cDGH4RWN"
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8584690
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 13:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742477332; cv=none; b=jsigFOad7UbkaPH1mYbZAwRLvq5Qt5CMh5gtCFBBKY7+/iPKSRFyDiHu2QgMAYEPGeyUJWHFXCJrT0xxMMKep/CbpIXyrn9FpMAdvUl3Jxma//JxELoGzN7B40MoX/djq5E/ABPWrYGezIY6M+MjkFf8QaC+7NoYBcT7V1WcEyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742477332; c=relaxed/simple;
	bh=h9AZOQS8pRvMAZnOSvwy/yZgh/0nzwC4JH9V8norXgo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N0tLAPJAR7LJwraMM+14pLqRiqWQtIV5ic2Q+5VH34MRc325BSX/sF7XF9K7zF0vQSUyNSLemi/tCXCrRSUFpVjzWtp+7xKQVPvPhCowbenJ9jbyyssdpqcKGl1Hez0KaiEbKWEvYwu/DddrGYlXXAyLW+u8emKWrHH+6JQuV1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cDGH4RWN; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b4f19dc0-6eee-4085-998f-b2739e15ba01@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742477328;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5bb2XlEIK7JJf1DCVVVr1W6LODizNqsLWPbdHJ5V49Y=;
	b=cDGH4RWNIQBZLYpHXzO0Go/+rwObMOpRs1SXfN5vQOukYPLzuIPvvHg5W7RRnkY9I7sCxz
	WXRN90oh16u4MeZP18CkOrifuqrJu/ML5zdcuS/w4rPKiDwAjJdO5ASMznZ34AahwugWSF
	HIGR1rs/dP+c5Af7VRzARNccqRs8rk4=
Date: Thu, 20 Mar 2025 18:57:53 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 3/3] drm/tidss: Add OLDI bridge support
To: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>,
 "laurent.pinchart@ideasonboard.com" <laurent.pinchart@ideasonboard.com>,
 "tzimmermann@suse.de" <tzimmermann@suse.de>,
 "simona@ffwll.ch" <simona@ffwll.ch>, "jyri.sarha@iki.fi"
 <jyri.sarha@iki.fi>,
 "tomi.valkeinen@ideasonboard.com" <tomi.valkeinen@ideasonboard.com>,
 "robh@kernel.org" <robh@kernel.org>, "airlied@gmail.com"
 <airlied@gmail.com>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
 "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "mripard@kernel.org" <mripard@kernel.org>
Cc: "j-choudhary@ti.com" <j-choudhary@ti.com>,
 "dmitry.baryshkov@linaro.org" <dmitry.baryshkov@linaro.org>,
 "u-kumar1@ti.com" <u-kumar1@ti.com>,
 "max.oss.09@gmail.com" <max.oss.09@gmail.com>,
 "francesco@dolcini.it" <francesco@dolcini.it>,
 "devarsht@ti.com" <devarsht@ti.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "nm@ti.com" <nm@ti.com>, "vigneshr@ti.com" <vigneshr@ti.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "praneeth@ti.com" <praneeth@ti.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20241124143649.686995-1-aradhya.bhatia@linux.dev>
 <20241124143649.686995-4-aradhya.bhatia@linux.dev>
 <4155a886b3b3027d4ca8bb7a13801852ef8754e7.camel@siemens.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Aradhya Bhatia <aradhya.bhatia@linux.dev>
In-Reply-To: <4155a886b3b3027d4ca8bb7a13801852ef8754e7.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi,

On 18/03/25 19:05, Sverdlin, Alexander wrote:
> Hi Aradhya!
> 
> On Sun, 2024-11-24 at 20:06 +0530, Aradhya Bhatia wrote:
>> From: Aradhya Bhatia <a-bhatia1@ti.com>
>>
>> The AM62x and AM62Px SoCs feature 2 OLDI TXes each, which makes it
>> possible to connect them in dual-link or cloned single-link OLDI display
>> modes. The current OLDI support in tidss_dispc.c can only support for
>> a single OLDI TX, connected to a VP and doesn't really support
>> configuration of OLDIs in the other modes. The current OLDI support in
>> tidss_dispc.c also works on the principle that the OLDI output can only
>> be served by one, and only one, DSS video-port. This isn't the case in
>> the AM62Px SoC, where there are 2 DSS controllers present that share the
>> OLDI TXes.
>>
>> Having their own devicetree and their own bridge entity will help
>> support the various display modes and sharing possiblilities of the OLDI
>> hardware.
>>
>> For all these reasons, add support for the OLDI TXes as DRM bridges.
> 
> ...
> 
>> +int tidss_oldi_init(struct tidss_device *tidss)
>> +{
>> +	struct tidss_oldi *oldi;
>> +	struct device_node *child;
>> +	struct drm_bridge *bridge;
>> +	u32 parent_vp, oldi_instance, companion_instance;
>> +	enum tidss_oldi_link_type link_type = OLDI_MODE_UNSUPPORTED;
>> +	struct device_node *oldi_parent;
>> +	int ret = 0;
>> +
>> +	tidss->num_oldis = 0;
>> +
>> +	oldi_parent = of_get_child_by_name(tidss->dev->of_node, "oldi-transmitters");
>> +	if (!oldi_parent)
>> +		/* Return gracefully */
>> +		return 0;
>> +
>> +	for_each_child_of_node(oldi_parent, child) {
> 
> Would for_each_available_child_of_node() make sense here so that
> k3-am62-main.dtsi would have both ports with status = "disabled" and
> the users will enable one or another?
> 

Thank you for the suggestion!

for_each_available_child_of_node() does seem to be the better option.
I will send another revision.


-- 
Regards
Aradhya


