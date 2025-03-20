Return-Path: <linux-kernel+bounces-569752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB38A6A718
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 14:25:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D877C4860E5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 13:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEC3021CC40;
	Thu, 20 Mar 2025 13:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="upRkIDwp"
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543981E5B6A
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 13:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742477102; cv=none; b=STn/5eB3mQ7+m4JqnLgyyi6TN9mqcCBoxIpXYjZblAXwiw3M0feLeBrL0HcC3tEynoX9M7LzPWFXZW+Hq1gJEzX/T+pm9Y5Z3N9rkz4f1Vi2HWd4UhmO7yxPhU8R/xHrUkF5nMqIxN2bxGP+RFxbAH20HIDDWMjUZkSSvGrMKNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742477102; c=relaxed/simple;
	bh=CQJgVxP67q4nLt1VGZxW4sjt4uFjV3uDcWhjP0Nv2Vc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MWAuAj5sucpnqus/GQb/ht16nugmF7oNS7nlrnBTffEdamqmbvz5DhuGTpOvQqfXf24pbzf9Qn9hlNnO2/ji5XDusrQTu5vyVVWjlsEFwTOcPF199qKjDU7WKKT2dlEWmoX7jdxXB7q9Tpqq8A0ASUlKE/RitEtvkfka+ICyMAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=upRkIDwp; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2c0b49a2-7cf3-4432-bab0-1eb110e8e8c2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742477087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k5XdiQFl3wHL7QNP07tkObb+sgwtdF2xYbguKHVcnVo=;
	b=upRkIDwpO4rHzaEi+hcMbgEBwiKyQQUVhZmYdXrv2e0R6BCFT8FGTje640+mtfOqQRdlvS
	iK44EU2bNCkwdtSqPCWXPaULCS3mMHs3DMorrOhoZT4xUOZPpD4Zg+bXbwnIzjPOTu0OhR
	YEVqZOamntJd13i7nLKonrbFytyAqeA=
Date: Thu, 20 Mar 2025 18:54:05 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 0/3] drm/tidss: Add OLDI bridge support
To: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
Cc: "j-choudhary@ti.com" <j-choudhary@ti.com>,
 "u-kumar1@ti.com" <u-kumar1@ti.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "devarsht@ti.com" <devarsht@ti.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "nm@ti.com" <nm@ti.com>, "vigneshr@ti.com" <vigneshr@ti.com>,
 "praneeth@ti.com" <praneeth@ti.com>
References: <20241124143649.686995-1-aradhya.bhatia@linux.dev>
 <8366a3d736f9937667aab024895a59e5947dd4a5.camel@siemens.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Aradhya Bhatia <aradhya.bhatia@linux.dev>
In-Reply-To: <8366a3d736f9937667aab024895a59e5947dd4a5.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi Alexander,

Thank you for testing and reviewing the patches!

On 19/03/25 23:30, Sverdlin, Alexander wrote:
> Thank you for the patches, Aradhya!
> 
> On Sun, 2024-11-24 at 20:06 +0530, Aradhya Bhatia wrote:
>> Regardless, I'd appreciate it if somebody can test it, and report back if they
>> observe any issues.
> 
> I've tried to test the patchset with necessary pre-requisites and DT additions
> with a single channel LVDS pannel and while I'm not successful yet, I've also noticed
> the following warning:
> 
> tidss 30200000.dss: vp0: Clock rate 24285714 differs over 5% from requested 37000000
> 
> even though later the clock seems to be correctly set up:
> 
> $ cat /sys/kernel/debug/clk/clk_summary 
> 
>                                  enable  prepare  protect                                duty  hardware                            connection
>    clock                          count    count    count        rate   accuracy phase  cycle    enable   consumer                         id
> ---------------------------------------------------------------------------------------------------------------------------------------------
>  clk:186:6                           1       1        0        250000000   0          0     50000      Y   30200000.dss                    fck                      
>                                                                                                            deviceless                      no_connection_id         
>  clk:186:4                           0       0        0        0           0          0     50000      Y   deviceless                      no_connection_id         
>  clk:186:3                           0       0        0        170000000   0          0     50000      Y   deviceless                      no_connection_id         
>     clk:186:2                        0       0        0        170000000   0          0     50000      Y      30200000.dss                    vp2                      
>                                                                                                               deviceless                      no_connection_id         
>  clk:186:0                           1       1        0        259090909   0          0     50000      Y   oldi@0                          serial                   
>                                                                                                            deviceless                      no_connection_id         
>     clock-divider-oldi               1       1        0        37012987    0          0     50000      Y      30200000.dss                    vp1                      
> 
> Looks like "clock-divider-oldi" doesn't propagate clk_set_rate() to the parent,
> but the parent is being set later independently?
> 

Yes, you are right. The "clock-divider-oldi" does not propagate the
clk_set_rate() to the parent.

The actual parent clock is now owned by the oldi bridge driver, and that
is what sets the clock rate (7 * pixel freq). The equivalent action from
tidss vp (DRM crtc) is a no op in cases of OLDI display pipeline.

Usually, the DRM crtc is enabled first, before _any_ of the DRM bridges
get pre_enabled or enabled.

Since, OLDI is a DRM bridge, the OLDI enable (and by extension the
actual clk_set_rate()) takes place _after_ the DRM crtc has been
enabled (which is why you see the parent being set later on).

DRM crtc enable is where tidss vp attempts (and fails) to set the clock
rate, causing the warning you see initially.


I have attempted to re-order the bridge pre_enable and crtc enable calls
in these patches[0], separately.

While you have mentioned that you did add the prerequisites, could you
confirm that you applied the (now older) dependency patch mentioned in
the v4 cover-letter[1]?
Ideally, you should not observe these concerns if [1] were successfully
applied.

More importantly, if you are already on latest linux-next, I would
request you to use v6 of this OLDI series[2], along with the latest
dependency patches[0], as the older dependency patch is simply not
applicable on latest kernel anymore! =)

I'd appreciate it if you are able to test the latest revisions on your
single-link setup, and report back any issue you see! Thank you! =)


-- 
Regards
Aradhya



[0]: Pre Requisite patches that re-order crtc/encoder/bridge sequences
(latest revision).

a. ("drm/atomic-helper: Refactor crtc & encoder-bridge op loops into
separate functions")
https://lore.kernel.org/all/20250226155737.565931-3-aradhya.bhatia@linux.dev/

b. ("drm/atomic-helper: Separate out bridge pre_enable/post_disable from
enable/disable")
https://lore.kernel.org/all/20250226155737.565931-4-aradhya.bhatia@linux.dev/

c. ("drm/atomic-helper: Re-order bridge chain pre-enable and post-disable")
https://lore.kernel.org/all/20250226155737.565931-5-aradhya.bhatia@linux.dev/


[1]: Dependency patch mentioned in v4 OLDI series.
("drm/atomic-helper: Re-order bridge chain pre-enable and post-disable")
https://lore.kernel.org/all/20240622110929.3115714-11-a-bhatia1@ti.com/


[2]: Latest OLDI series (v6)
https://lore.kernel.org/all/20250226181300.756610-1-aradhya.bhatia@linux.dev/


