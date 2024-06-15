Return-Path: <linux-kernel+bounces-216027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47398909A14
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 23:58:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC2AC1F21767
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 21:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7235361FE5;
	Sat, 15 Jun 2024 21:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="UVn4OWKj"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1981849
	for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 21:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.172.40.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718488702; cv=none; b=XzVYDdRghsxCrld9I3CbWdkFJiXPW+esOEIwGPFgQ6/o3C1f92GnGSeC2ENQaESeZzxqVf4N5ppa5XyZ2Ff5OTLYF9i8DgdEpI2ekQFgi02qybgxUkmcPRLpDNAHVOWVVazRKdodNHLsLdK2DEta0pmhP7SgBkfyIzR2uPePGz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718488702; c=relaxed/simple;
	bh=RQwam8heKzHhFBrjNH3n7ZNe/fUbTPDtmcKQZM4N5TA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HAxpoeWgpLtAe1zg4ANnHXIbHGyehoZQ2KIbHVL/qtzQ5L39EMPyRNvNzWW2SEtX4mmKyOy1yRxbU3IjhlpknlJnJu6YE5jAj37PInBnSNm1pvQtBN3qedRlCUTmLfI/QKrcJC13BNyRU60zFi6PSksIc/Blp6Zo5B8WmaVJhbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=UVn4OWKj; arc=none smtp.client-ip=167.172.40.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1718488674;
 bh=CV/mgUWgMh4+uV6CKW6yanETiH58y91gnPr01uQkQ8k=;
 b=UVn4OWKjypaU+NM3VrcShJnaPz42ArY3uHbpDfMAjfG72ySTdUU4EwLn7Nwl6CvqsbpDTOTF9
 3di3dl/H60nAr7nF3epMiJHFdZnQbLfx0iktuRcvF+4IWiy5zB+ETUEV2sa9co4tPXKKc7qv8d6
 02vEGhoumsScvcvjHxCh6qwv1p62OpQ62vUAm/lq4fwlZ9j5xVCdBXa5wkezHBI/9IG8seUXm2R
 3Tci24wzeOJb3huCJhy6DnZVFPXY/A41L/P0BVjHXqZYZowLc6NPq34DVu8v/60siHgCAJze5eP
 6Zb9TAGw3V4c9YVtqD9Y/VpLGYTV5Qh+wo8eHLJpz8BQ==
Message-ID: <ff18a3dd-3e39-4dfd-8e0f-6401b3df531c@kwiboo.se>
Date: Sat, 15 Jun 2024 23:57:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/13] drm/rockchip: dw_hdmi: Add max_tmds_clock
 validation
To: Diederik de Haas <didi.debian@cknow.org>
Cc: dri-devel@lists.freedesktop.org, Sandy Huang <hjc@rock-chips.com>,
 "=?UTF-8?Q?Heiko_St=C3=BCbner?=" <heiko@sntech.de>, Andy Yan
 <andy.yan@rock-chips.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240615170417.3134517-1-jonas@kwiboo.se>
 <20240615170417.3134517-7-jonas@kwiboo.se> <2357044.LC0K3s5jzQ@bagend>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <2357044.LC0K3s5jzQ@bagend>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 167.172.40.54
X-ForwardEmail-ID: 666e0e5eb23880544d1f8be8

Hi Diederik,

On 2024-06-15 23:53, Diederik de Haas wrote:
> On Saturday, 15 June 2024 19:03:57 CEST Jonas Karlman wrote:
>> The rate limit for RK3288, RK3399 and RK3568 is based on current mpll
>> table. The rate limit for RK3228 and RK3228 is based on the
>> inno-hdmi-phy pre-pll table.
> 
> I see RK3228 mentioned twice; I guess the second should be RK3328?

You are correct, a copy/paste error, thanks and I will fix in v2.

Regards,
Jonas

