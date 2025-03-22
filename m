Return-Path: <linux-kernel+bounces-572597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B859FA6CBFE
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 20:34:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7CDC3B00E5
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 19:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AFEB233D93;
	Sat, 22 Mar 2025 19:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZiKUU8wX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0BA376F1;
	Sat, 22 Mar 2025 19:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742672087; cv=none; b=anCheE2+utE5ot3x7D0qpK+yfhpyxVwzgNbsh3D5cfla399Veue9ptlreLtvZBfqrVQ9hkONT9cypHzPhx5IyIGNluoco3tBtnKcFsPHS15Ab4uDacHLBm1Z2qNu6MlIpzm0TuGWyJPUI85MiuiCCBix5acoxE1XqAl4RtWr3Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742672087; c=relaxed/simple;
	bh=RInUAuG0YDS4IqSr2bPqz7JUlid5tiBccn1YLRGnwX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QU8kxx/LDUjlXBg4odegPP9taDnBoF8wPmumCimcNVvUWmbwR/TRp447cRUzhSY0DelhqezF9EfzP9Hxmo6kbAP9/nTyJ3MVJZ6JbUQHKZqt+3A4XeKQrOhC18fD16rCI2xl9rVmXVQZ2+C/siNjMYB6gseUjm+lPPIbS2p0hCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZiKUU8wX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8AB6C4CEDD;
	Sat, 22 Mar 2025 19:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742672087;
	bh=RInUAuG0YDS4IqSr2bPqz7JUlid5tiBccn1YLRGnwX4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZiKUU8wXyQ+I0ZDP1e9LPKT2fDSxn1CuE9UR2ejqTPS3QcKNXfU3AhI1bdoCXYAkx
	 2AdyXvVPWTjvtlJDZJPpMMetD58kRQj86fbSztV7HLC3bzMrYibE8F9XYq86v0A3Vt
	 9s9AQLF3jYRlQF7Q7HVVN5OeobZ552vJ1hfV4D6E=
Date: Sat, 22 Mar 2025 12:33:25 -0700
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Johan Hovold <johan@kernel.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] USB-serial update for 6.15-rc1
Message-ID: <2025032217-copious-blade-a54e@gregkh>
References: <Z915ASU5AKnAigu1@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z915ASU5AKnAigu1@hovoldconsulting.com>

On Fri, Mar 21, 2025 at 03:34:41PM +0100, Johan Hovold wrote:
> The following changes since commit 0ad2507d5d93f39619fc42372c347d6006b64319:
> 
>   Linux 6.14-rc3 (2025-02-16 14:02:44 -0800)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git tags/usb-serial-6.15-rc1

Pulled and pushed out, thanks.

greg k-h

