Return-Path: <linux-kernel+bounces-397762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC07B9BE000
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 09:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 603791F23940
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 08:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC12C1D31B2;
	Wed,  6 Nov 2024 08:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="o7duiaOW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4006C19148A;
	Wed,  6 Nov 2024 08:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730880622; cv=none; b=BF1+H7DM6iq6kbKOhUdvUGtaeMMQHJvRHE8FfJoJfWWRxRfJsRXAw9DTPQEvJXbhTtViqcqkk7I3Iml+zZVmVali2SQtk4jJ83JD/dzUcElpgfPYT8wGar4wi8jDh6/0Z8klTWkBsZCh2KZyziIFuD7Mbc3bdpKkDY1ojFi69Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730880622; c=relaxed/simple;
	bh=KZ8aBWBC6rv25YMrg2zHEHoVtOEBWRyUHz/BlKlWqn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f7/cKaJS7Ts8dncN7eKMSpniKSGEgGoX9aBaQHwT19CoKBTrF/u+LyN09coDzPK2pWqYORnUDp1/3CVkUlwMTRwWxdpOdO+nc01N3AF07DALvgq/fGNrwk82CsqBZiI0+sNt2Loi3B5i6F4gXy7XqhuLdBAdMd2R4obx0B+tJ4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=o7duiaOW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FF7AC4CECD;
	Wed,  6 Nov 2024 08:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730880621;
	bh=KZ8aBWBC6rv25YMrg2zHEHoVtOEBWRyUHz/BlKlWqn8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o7duiaOWrkEP5F8V4tgcT6Lhe2v1GQVNC4GUn+rF3gBTNdx0KIn5U7IQCqHP0l2Wj
	 bVc2HIDFtcheCexV0KCQravF4ADo028uGNeSlH3x71+R8W4aX5rw4tmGkS1D/KVkY7
	 NkipgjDGX3T0X2vEMh7PhYOC9xXJvCM0SKFEiS6Y=
Date: Wed, 6 Nov 2024 09:10:03 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: "Liao, Bard" <yung-chuan.liao@linux.intel.com>
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	mstrozek@opensource.cirrus.com,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	bard.liao@intel.com
Subject: Re: Request to backport "ASoC: Intel: mtl-match: Add cs42l43_l0
 cs35l56_l23 for MTL"
Message-ID: <2024110635-directive-steadier-9ab2@gregkh>
References: <448a5371-75d5-4016-9e6d-d54252c792b4@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <448a5371-75d5-4016-9e6d-d54252c792b4@linux.intel.com>

On Tue, Oct 22, 2024 at 07:31:42PM +0800, Liao, Bard wrote:
> Hi,
> 
> commit 84b22af29ff6 ("ASoC: Intel: mtl-match: Add cs42l43_l0 cs35l56_l23
> for MTL") upstream.
> 
> The commit added cs42l43 on SoundWire link 0 and cs35l56 on SoundWire
> link 2 and 3 configuration support on Intel Meteor Lake support. Audio
> will not work without this commit if the laptop use the given audio
> configuration.
> 
> I wish this commit can be applied to kernel 6.8.

6.8.y is long end-of-life, so there is nothing we can do here.  Please
always look at the front page of kernel.org to see the current active
kernels.

thanks,

greg k-h

