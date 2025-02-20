Return-Path: <linux-kernel+bounces-523496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E3AA3D793
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 11:59:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40A5F3BE7EC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 10:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A68B1F152F;
	Thu, 20 Feb 2025 10:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s8fzb6/7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C898C1F12E0;
	Thu, 20 Feb 2025 10:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740049083; cv=none; b=IVTnej4N2+MPF4q+t/Pi5a7V3evK4H8/98dGku0xsxzAJGAUCmy9HZngWxf269XuyUMhDLiU0ivGs7t4D0QXfoky9ZZPRKbO65HqVWyzKk5BWZ0BjF6LnU9Kt5DJiFoTQXilGCAkwLtXr7f+BFgjTyhZo0EhpUVooN8318vveU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740049083; c=relaxed/simple;
	bh=u/HRjDo/WO6OCy5SnAsbPDEYLwXtjJNTDbTzvnDkk1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HZ5CKcMtvrMfRPFl/XqJOrCs2Vgi1rEebSAhq4a/WuzgOork/b+TQ4Zoz0jklOa7V2WMC1bHg9sI14bRIcS5s7VJMGntC9IHrVR1fxLvKgMG9kEt5fBb/5bSPvcdGSRfYCR+BQoo4CTDGQYiwIfPM2TsU1rodBrXBL+1uSgqAis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s8fzb6/7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9014CC4CEE4;
	Thu, 20 Feb 2025 10:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740049083;
	bh=u/HRjDo/WO6OCy5SnAsbPDEYLwXtjJNTDbTzvnDkk1I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s8fzb6/7+R9aq4DgOs0UdnFguGnMxstXCYm+G3JktzzEYDB/GV00cXLeihMiU2X07
	 nTMCqxEkqfQWm2tY3pcl2kVxXd2dECT7KY83ZmIxJKl9m/dy/O9d6KB1loGladPStg
	 CtuyZv7XCV05Cq2tp03pH7ZccMx9Samz8VjDYeAVGv5WjAgTh0X1+tLEDXG+9KAj63
	 QLlSjHm5iMnIqLzKJDFMXi9PHOB+wQ4qyOyPyX5OrFDwCHMXsaYyhjEXUQZtMyQ6wI
	 pdeSP5SmYbK7woCpotk6ptHotEV6WyZLSNnq37QnuRwFuEon4uh4iVzyQ+YbmopkdU
	 3Tcm/dhOZNquw==
Date: Thu, 20 Feb 2025 10:57:57 +0000
From: Lee Jones <lee@kernel.org>
To: Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, tsbogend@alpha.franken.de,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-mips@vger.kernel.org
Subject: Re: [RESEND PATCH net-next 1/5] dt-bindings: net: Move
 realtek,rtl9301-switch to net
Message-ID: <20250220105757.GA8787@google.com>
References: <20250218195216.1034220-1-chris.packham@alliedtelesis.co.nz>
 <20250218195216.1034220-2-chris.packham@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250218195216.1034220-2-chris.packham@alliedtelesis.co.nz>

On Wed, 19 Feb 2025, Chris Packham wrote:

> Initially realtek,rtl9301-switch was placed under mfd/ because it had
> some non-switch related blocks (specifically i2c and reset) but with a
> bit more review it has become apparent that this was wrong and the
> binding should live under net/.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
> 
> Notes:
>     It would probably be simplest for this to come in via net-next with an
>     ack from Lee.
> 
>  .../bindings/{mfd => net}/realtek,rtl9301-switch.yaml           | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>  rename Documentation/devicetree/bindings/{mfd => net}/realtek,rtl9301-switch.yaml (97%)

Acked-by: Lee Jones <lee@kernel.org>

-- 
Lee Jones [李琼斯]

