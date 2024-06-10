Return-Path: <linux-kernel+bounces-207735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78039901B38
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 08:25:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F3DDB22C23
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 06:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AD6818633;
	Mon, 10 Jun 2024 06:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zb3TtYbg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E81D17C91;
	Mon, 10 Jun 2024 06:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718000728; cv=none; b=QFXvAkQo8sTsQHjJmgEi6pvtBfHeeJ4Ijhq30gaJxqQGFHIdj2r6syGmKsIgjRubD/f83rFKFc0lue1/umBGn1V4q4sPWFA6U+D+fYoexsvopIYe34PptUCO7YDbfR3dSpJhq4RIIupYuZwvbqa5JRLsaweMFuB3iu4jKaf3gLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718000728; c=relaxed/simple;
	bh=kFnEOlKoCXi9xsfPM/KcDWCHzC3Nd4WkcUBue7po2kU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rUlXWB/IW66HwzZyjvvcSSU7gTyPoTSIRYvWOOpkyTKNbGkKhGLLSDM/owehG2sft9A/vNBb4MNDCviHUk8pCuNQWHzqodnKHKL+7mSTzXupfTREgRy1YdCkoQeLjLo9xwEv+Pi8gxhKlxhnXxPlwWDgF1UomlBn2ReOY21pKXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zb3TtYbg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99919C2BBFC;
	Mon, 10 Jun 2024 06:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718000728;
	bh=kFnEOlKoCXi9xsfPM/KcDWCHzC3Nd4WkcUBue7po2kU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=zb3TtYbg138HkVOo20OzWd9hMHjVPbcQXaAyueVnv6sHDsQLmoQZrR7Q5hIcz0fW7
	 pJY2k6B9pY1oo4aCj1nJIhqibXQUGM6HFjKDb07QiwNPz6w63+GI5rSLBIr4VGEziU
	 an7NqRPhvrPcT1d72wjiicrSAiBYMs2t/RioMI38=
Date: Mon, 10 Jun 2024 08:25:24 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Tree Davies <tdavies@darkphysics.net>
Cc: philipp.g.hortmann@gmail.com, anjan@momi.ca,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/24] Staging: rtl8192e: Maintenance renames and cleanup
Message-ID: <2024061059-coziness-tacky-28a0@gregkh>
References: <20240610054449.71316-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240610054449.71316-1-tdavies@darkphysics.net>

On Sun, Jun 09, 2024 at 10:44:25PM -0700, Tree Davies wrote:
> This patch series attacks CamelCase variable renames, removes
> un-used variables and adjusts alignment issues found in
> rtllib_rx.c and rtllib_tx.c. 
> 
> This completes the last of the remaining checkpatch issues 
> for rtllib_tx.c.
> 
> Thank you in advance to all reviewers.
> ~Tree
> 
> 
> Tree Davies (24):
>   Staging: rtl8192e: Rename variable bHwSec
>   Staging: rtl8192e: Rename variable bIsMulticast
>   Staging: rtl8192e: Rename variable HTCurrentOperaRate
>   Staging: rtl8192e: Rename variable HTOpMode
>   Staging: rtl8192e: Rename variable bRTSEnable
>   Staging: rtl8192e: Rename variable bRTSBW
>   Staging: rtl8192e: Rename variable bCTSEnable
>   Staging: rtl8192e: Rename variable bRTSUseShortGI
>   Staging: rtl8192e: Rename variable bforced_tx20Mhz
>   Staging: rtl8192e: Rename variable bPacketBW
>   Staging: rtl8192e: Rename variable bBroadcast
>   Staging: rtl8192e: Rename variable CntAfterLink
>   Staging: rtl8192e: Rename variable bUseShortGI
>   Staging: rtl8192e: Rename function TsStartAddBaProcess()
>   Staging: rtl8192e: Fix spaces/tab alignment to match open parenthesis
>   Staging: rtl8192e: Rename function rtllib_query_BandwidthMode
>   Staging: rtl8192e: Rename function rtllib_query_ShortPreambleMode
>   Staging: rtl8192e: Rename function rtllib_query_HTCapShortGI
>   Staging: rtl8192e: Rename variable bUseShortPreamble
>   Staging: rtl8192e: Rename variable bRTSSTBC
>   Remove parameter bIsAmsdu from rtllib_classify()
>   Remove variable IsAmsdu from rtllib_xmit_inter()
>   Fix space/tab alignment to match open parenthesis in rtllib_tx.c
>   Fix space/tab alignment to match open parenthesis in rtllib_rx.c

Any reason why the last 4 patches lost the "Staging: rtl8192e:" prefix?

thanks,

greg k-h

