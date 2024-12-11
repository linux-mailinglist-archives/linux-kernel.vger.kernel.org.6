Return-Path: <linux-kernel+bounces-441032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4FD9EC86A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 10:08:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8039B1889B24
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 09:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 333D72210D2;
	Wed, 11 Dec 2024 09:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FVMaxRey"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA3B2210C1;
	Wed, 11 Dec 2024 09:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733908089; cv=none; b=EjNTbr9PhOkt67I0hkP9+mGOEjopv3hyMPQFZwV4dUUSAE8FBPx3LRheHKreyJWKG7gmIW31xgdAGte1DYU7H6bdf8c/Y1nG9CdovcJO7NOSzPSNdp23SO3mdaOkWXGmSzsHLoexK5+us7779te5QBp/YIE4e3cJhKCTMjwGpeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733908089; c=relaxed/simple;
	bh=bv9Y+hf1VlAuKDlGy7koqHy8VGN++ksROqJbZicEB7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pOiS97F9pyUL+tSFgYlnBGoY9mHEQLwYh9YBoUYdy3YbUpMFngDLhSStosWnvblEZ9oq77dcLS0muAc6xQa2WGJJvc7pYAaqpx49OUBikKNKntn0GBCjFwSjk/C4HkbOGXTSkMqjT5D2Y3c7a5f7kjOIQNQWlWeZEdqeVsD8owA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FVMaxRey; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BB0FC4CED2;
	Wed, 11 Dec 2024 09:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733908089;
	bh=bv9Y+hf1VlAuKDlGy7koqHy8VGN++ksROqJbZicEB7o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FVMaxRey1qMv2DBvIBVVLEX4o1+/auPztiWS1fvZZbEHvbi3vAPN0P2mK5hu0twib
	 7YJTpD9O7TrcqVk2cdVcd7PZF6EfArG8zwW77xD74bHQtnfKhHlvYa+pep4GMMWo+N
	 IYn+PP7l7/VYD4usf+Z+dAJehZqmqUtd9xqerObqwfd9Zzbu0HJOn4E9OIA9FPo4hE
	 mj/HehEiiiF2okyGOU8htLyq13W8gr8iFUZkeHBppxO8em1pP9mGZ4m1e6Oo+fumHJ
	 1yT/tcO6J4lo0eVViHOEAPX0WDcsCGS1Xrd5PVkgpl6maoaeURfRGH2fK+1/GzlAgV
	 R8Vaf2UjuJyUg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1tLIhY-000000002fO-1Bow;
	Wed, 11 Dec 2024 10:08:12 +0100
Date: Wed, 11 Dec 2024 10:08:12 +0100
From: Johan Hovold <johan@kernel.org>
To: Michal Hrusecky <michal.hrusecky@turris.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: serial: option: add MeiG Smart SLM770A
Message-ID: <Z1lWfG8qe8bPKHZt@hovoldconsulting.com>
References: <6uel66cvf2cn2jenpoc43usee3pwnmtaerqnpfl7tnoa6s5mff@5xxrpbabupah>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6uel66cvf2cn2jenpoc43usee3pwnmtaerqnpfl7tnoa6s5mff@5xxrpbabupah>

On Tue, Nov 19, 2024 at 02:00:18PM +0100, Michal Hrusecky wrote:
> Update the USB serial option driver to support MeiG Smart SLM770A.
> 
> ID 2dee:4d57 Marvell Mobile Composite Device Bus

> Tested successfully connecting to the Internet via rndis interface after
> dialing via AT commands on If#=3 or If#=4.
> Not sure of the purpose of the other serial interfaces.
> 
> Signed-off-by: Michal Hrusecky <michal.hrusecky@turris.com>

Now applied, thanks.

Johan

