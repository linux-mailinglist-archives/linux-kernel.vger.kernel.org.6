Return-Path: <linux-kernel+bounces-392850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4590A9B98DA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 20:45:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F17D31F21762
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 19:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4DB41D12EC;
	Fri,  1 Nov 2024 19:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j+pWNYJ6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254B21AAE3B;
	Fri,  1 Nov 2024 19:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730490313; cv=none; b=WyrW7uuqa+u0QibCNI4kCsTmAra6KPwnjqYjzMj46qMlvecgUDYz26Zu8A/Me2HgjWZdAEPCjQhbgNbJZRUX9Uhp8+gzuZ3yqZBSkJXxaT8menSqpfsQsGxL+m3tq3DEe+vMFmxuw0IQzv/3eAWX5UTwlKM8HjyJPHflFOOeTyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730490313; c=relaxed/simple;
	bh=CRdQBpRAysB9a5OIXPNdrJhTutPMcFg/qkvbhwRmztY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lc6tBVJOtErczKcUwxIjH8Lj2HkOy6rSNLxQxxYxdiLK2MWdk9uhMVuKZ0e88mIrEssfsto91CahVhD7KHQNv0rU97ZtNS6u5YXkGSEBhehEP0mkUiXT030Mn15e/rfljWugMxRK2jeGKcmfGoJSG2s1plS1YsxrIU3D+2V33/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j+pWNYJ6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EA91C4CECD;
	Fri,  1 Nov 2024 19:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730490312;
	bh=CRdQBpRAysB9a5OIXPNdrJhTutPMcFg/qkvbhwRmztY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j+pWNYJ6ohvkjKbabfD4dNK+LsavG1WiZMJfGJO3q9ZGnxX8gMIf8AQZ7D4D6zX4/
	 aq4WpYJLmryXu9XIoDtcbspFtUYOvDcoYL/2KPrfojvSDdK5kaorfFauHvJRrhm8Ox
	 IghaszUMA494tbMy49yjyucEDj0vEObEO4+bqTCDHahwU4nek4BjyhXC6/Du4lnWo6
	 1x9dSHDIRUiuRfzKNaczAWS2QL1AuPGF5BuSwZCANEZl1D7WIN5nvmEX162c4VZ1Ec
	 Idc1j5ycvkb935nmVXdqa4feY785eYYGHiLzBk/tYde8lFjEwu9fb2ZQfQgZAQJw4V
	 JXxTnp7GRtW1w==
Date: Fri, 1 Nov 2024 14:45:10 -0500
From: Rob Herring <robh@kernel.org>
To: Stanislav Jakubek <stano.jakubek@gmail.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Wenhua Lin <wenhua.lin1994@gmail.com>,
	Wenhua Lin <Wenhua.Lin@unisoc.com>,
	Xiongpeng Wu <xiongpeng.wu@unisoc.com>,
	Zhaochen Su <zhaochen.su29@gmail.com>,
	Zhaochen Su <Zhaochen.Su@unisoc.com>,
	Xiaolong Wang <Xiaolong.Wang@unisoc.com>, linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: pwm: sprd,ums512-pwm: convert to YAML
Message-ID: <20241101194510.GA4080473-robh@kernel.org>
References: <ZyH-JASRcpMXYsmH@standask-GA-A55M-S2HP>
 <ZyJ0urvkMZVzZa7S@standask-GA-A55M-S2HP>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyJ0urvkMZVzZa7S@standask-GA-A55M-S2HP>

On Wed, Oct 30, 2024 at 07:02:34PM +0100, Stanislav Jakubek wrote:
> Hi all,
> 
> just noticed this older patch [1] doing the same conversion, so I've also
> CC'd other people from that patch series.
> 
> [1] https://lore.kernel.org/lkml/20240125025533.10315-5-Wenhua.Lin@unisoc.com/

Always nice when we take the time to review stuff and it never gets 
followed up on. :(

> 
> Sorry for the noise,

Your version looks fine, so let's take it. I don't expect any follow-up 
9 months later.

Rob

