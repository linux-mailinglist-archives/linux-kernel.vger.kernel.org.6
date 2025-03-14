Return-Path: <linux-kernel+bounces-560873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9BF6A60A61
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 08:51:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77FDB3BAFF3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 07:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE9B1A2390;
	Fri, 14 Mar 2025 07:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="r/rCDGnp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833E119D06A;
	Fri, 14 Mar 2025 07:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741938642; cv=none; b=CSF1gsXPqUqWrC2Dn0rRCC7gHYIogdO5hScW2Htj9XdDybYdvWvthYMXRYS0jg65o8W/Q9VkDBGMDT2fXlYjOuJaRY3Mp/gC624n3IxY3GvbL3+3QvBwSQIZqrdztcdTJI1DoM+DQSsaL8zB1F97H8WGb8vaVEV0RV6BRbDQNEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741938642; c=relaxed/simple;
	bh=My0VdKrSEOPLa4gBGlIMgdJzO1L3iy3brX9NlIYPvC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KDwGxV4/W84jWwVwoWMdfk4xqw/SCBec4c0tPaTo7+K0pf7lL4Qn6XifCklnNVRmCbVrBIrKcSwcTknSN1fm3+0snQLHPArmjrJt/WA3PEz3zzwz2USKdgcantPJla1did6RFMYPeSy4S8Cvx7blRl6MdftJNXfoRY8Sr+/URGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=r/rCDGnp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A685AC4CEEC;
	Fri, 14 Mar 2025 07:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741938641;
	bh=My0VdKrSEOPLa4gBGlIMgdJzO1L3iy3brX9NlIYPvC0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r/rCDGnpFWMGCUYJqfrvFhcq9lNBr8E0sCuzexykRadyPmhNUIQvJDJu5Pa4RrQEt
	 K7m3jD3OFj91sbNP44zdT2r7Pos+nDt25JKvPgd2c8kRGZeqmoGpRx8rB5WvVSRCOo
	 q+EPBeMjNfMKHvyGnDqBPN9DTCUHxoI7FCEIKPFg=
Date: Fri, 14 Mar 2025 08:44:05 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Johan Hovold <johan@kernel.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] USB-serial device ids for 6.14-rc7
Message-ID: <2025031458-mounted-linguini-264b@gregkh>
References: <Z9PW5tkuTH6oRG6X@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9PW5tkuTH6oRG6X@hovoldconsulting.com>

On Fri, Mar 14, 2025 at 08:12:38AM +0100, Johan Hovold wrote:
> The following changes since commit 0ad2507d5d93f39619fc42372c347d6006b64319:
> 
>   Linux 6.14-rc3 (2025-02-16 14:02:44 -0800)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git tags/usb-serial-6.14-rc7

Pulled and pushed out, thanks.

greg k-h

