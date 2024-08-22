Return-Path: <linux-kernel+bounces-297857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7745595BE9D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 21:00:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 656021C21833
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 19:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC8D61CCB51;
	Thu, 22 Aug 2024 19:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r+8XslC5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E881EC5;
	Thu, 22 Aug 2024 19:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724353251; cv=none; b=Fv2d4aPcI1y3P/Dl5WV8JMGovE34b+LFAHIXG23tZ+BKqwuRxt7JD5i1JgVCnjpr6Q/VC7RBFYRuB+oENAYbMvbUNphftd0CDjjssjYhz4Irb0ZM9zPa1w2k/FMkgnsVyirTAg1r5TNuHkA81p/o7wVrNC4eM8iJ6xDkdxSk/4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724353251; c=relaxed/simple;
	bh=Ui017gkewD7xFMBxW+cEVmQbEQy8O8gCGcb0gCACXog=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=VM5yy6IxmmiYQpdccdU0d+716sB4U24lZRTODfn4PzNGWEGL0pVHXJHiUI0ahn0mOJnplVL3HzkPV79XUeJzQCgHZdgR64U1QFbqXeBUnCbiK/3/vibQaTNQI0SbHQTOzA/CpB27DhMD9dWOnkvbq/dIKwH8euGyUSyuta1847E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r+8XslC5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39636C32782;
	Thu, 22 Aug 2024 19:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724353250;
	bh=Ui017gkewD7xFMBxW+cEVmQbEQy8O8gCGcb0gCACXog=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=r+8XslC5/W4OqDFPYi73HsDjFSS0ECICdazXPhvYBpslrDvVROAT47eKZ8b/1LcCn
	 60ZytwM2oGeiL6VWRfDcco6/ZiqdwWbYtEY9i6uwbK7dqbZ56VE0nu1do7uT8N8rTn
	 gJ9dXcySvQj5f31NUD7ggPzjvvxgm2WMzTssYEflgfDqLhRl+P3ILWn2FVDwK2LJha
	 ZSOZfcfG69Y72ow/7jGEfW/TnTYOFfD/G2+ecdz7W2P68F/QTmjAqShTL9XSf1GXHp
	 eTpH42U0GKUly/tR5S9k/0I7RNLnGLcfFcwOIjxCFbzKDwn1VOSIO/edjtXsElzqKn
	 fkKTp9WxNwAuA==
Date: Thu, 22 Aug 2024 21:00:48 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Doug Anderson <dianders@google.com>
cc: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>, 
    bentiss@kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
    robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
    linus.walleij@linaro.org, hsinyi@google.com, 
    dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/2] Add Add elan-ekth6a12nay on the basis of
 elan-ekth6915
In-Reply-To: <CAD=FV=V8ivgWn5krEYzt5C4aiHMMK07mtMVwJaCeSQHG6ZscSg@mail.gmail.com>
Message-ID: <nycvar.YFH.7.76.2408222059160.12664@cbobk.fhfr.pm>
References: <20240722073136.8123-1-lvzhaoxiong@huaqin.corp-partner.google.com> <CAD=FV=V8ivgWn5krEYzt5C4aiHMMK07mtMVwJaCeSQHG6ZscSg@mail.gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 22 Aug 2024, Doug Anderson wrote:

> Jiri / Ben,
[ ... snip ... ]
> I think this series is ready for you to merge at your leisure. If
> there's anything blocking it then please yell. Thanks! :-)

Hmm, for some reason the only mentions of this series in my inbox are your 
Reviewed-by: from Jun 10th, but nothing else whatsoever. Seems like some 
spam filter really didn't like it.

I will pick it up.

-- 
Jiri Kosina
SUSE Labs


