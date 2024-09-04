Return-Path: <linux-kernel+bounces-315582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0249596C46C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 18:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DFB11F245E0
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 16:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71591E1312;
	Wed,  4 Sep 2024 16:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g2oWSt1q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2941CEE89;
	Wed,  4 Sep 2024 16:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725468671; cv=none; b=a6x86M9Yo568yd8g7WzJIvTTvydCh3lFBdU+a7wlHYiVr91tM8gt2CPxwr1DXmmMrjkSn/OOsDrs/huKRY4UM/lpfgFZEXCuoSKiYQWR9ZlFC9h9mFr/TpZfPsxllhNVcKw871lC8xCCd5WhrvaFc5ILQsVDcjXdiRTUJfFmapM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725468671; c=relaxed/simple;
	bh=L9Tfmi5LsksGJEqBB53mgnYCUnHvcd71N1iGKRTea3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FwhDIsc+kuJEWFg2t/fmTXTQ35BleECYX68LtYuFTJ6NFKPnQsYpcX49EAUwDGeAlr4kjDT4jaDcYgJn/KVrXhmmOu5TLrgvLAuqxCrnT23Yv6Oxe2zSIKsD73qAY65p8JbPKur5xaw+5YnkC34XNYldierxcj8KygAk9PasFt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g2oWSt1q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6EB9C4CEC2;
	Wed,  4 Sep 2024 16:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725468670;
	bh=L9Tfmi5LsksGJEqBB53mgnYCUnHvcd71N1iGKRTea3g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g2oWSt1qkdY2ZqGJISu2NeLeBUcEWRzFULEiWacSzP8Swtp2GJOMxKNQDRxOyDj7Q
	 mbI6z08/d8rMr8J5+uXoDTyGgAylC5h77alIQFVq1ULyEzvoUU8buCutbJUYOhjW7Y
	 /pTv4RCsx4/wBKIcGCuxU8JLLdLaqOqXrAeQ3eN/u0LC07OWuH1uQjRd4Cc4O5/02t
	 +eLggZovj62tCHgJFe7IMlIdpoytePMqWxdZ3HA5nMZ9AwXF4pSaZsYXe9fnir0pHy
	 JA6SQOyCVoI7HTfoksID4Pl9AUhN7qKlneh99r+/ETv9DxQOjuk2o47T0hx+cQSbem
	 r+JXXNd2qhdSg==
Date: Wed, 4 Sep 2024 17:51:07 +0100
From: Simon Horman <horms@kernel.org>
To: Chen Ni <nichen@iscas.ac.cn>
Cc: richardcochran@gmail.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] ptp: ptp_idt82p33: Convert comma to semicolon
Message-ID: <20240904165107.GC1722938@kernel.org>
References: <20240904015003.1065872-1-nichen@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904015003.1065872-1-nichen@iscas.ac.cn>

On Wed, Sep 04, 2024 at 09:50:03AM +0800, Chen Ni wrote:
> Replace comma between expressions with semicolons.
> 
> Using a ',' in place of a ';' can have unintended side effects.
> Although that is not the case here, it is seems best to use ';'
> unless ',' is intended.
> 
> Found by inspection.
> No functional change intended.
> Compile tested only.
> 
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> ---
> Changelog:
> 
> v1 -> v2:
> 
> 1. Update commit message.

Thanks for the update.

I checked and I was not able to see any other instances of this
problem in this file.

Reviewed-by: Simon Horman <horms@kernel.org>

