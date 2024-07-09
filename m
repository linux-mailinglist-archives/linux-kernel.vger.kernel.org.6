Return-Path: <linux-kernel+bounces-245779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 943C692B91A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 14:11:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E4C4281D01
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 12:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F353F15886D;
	Tue,  9 Jul 2024 12:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XunaiFWx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6C31586D0;
	Tue,  9 Jul 2024 12:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720527108; cv=none; b=VwdWMHC4p7aACeHrgVGNVfhlv4YiUVBXC2z4wvXIZ+rVs9x8CB4bgpk8iRf8y5ggGHQFVzbDbYxgi+rQXRP4YbKLAmrIxryFLC2mUf0ZEXLEetzVAXYE/cTKV8Pgi6386jPUGEfpDsCJSeVQxklyG8LOqfR8HZZToGC8cGPghFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720527108; c=relaxed/simple;
	bh=6nXVBHxapGeNFY9Doi4AYcoTeU4i7m2iH7ympobUD+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GFVZc7WF/VVUk0Z91m+gXP9Db7hD3H+YNimh32l+5f+bYpcvOmb150pday/btgvgK2hNqLsq9gqTCSY+hNJZyUimjautyWuf34OS4/1G/ZljTyFK3WXFzzRw3Nr7EuPykDsV6y93vVwk2NziZX7jUXHEzhjFtBUkZ6Ai5Xeu6GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XunaiFWx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C104C3277B;
	Tue,  9 Jul 2024 12:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720527107;
	bh=6nXVBHxapGeNFY9Doi4AYcoTeU4i7m2iH7ympobUD+8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XunaiFWx6CoaAG36CDIBI6fhvQdURFF+NraJ27x73m/m/yWAzbBlEJ43TKd9Kp3Oq
	 oy8tVGQFyq1eJ3bneAH4waurF2ftQF9wkxUhh1dqx9EupGUBsECJhKF6XDUjgteWjz
	 3fokadd7SiaTWsYaSaAr8At3Mtyp1dMG+FSwAnKjLgR8xpBcy9obp3gqILnC2z6RBr
	 vAAM04lvTodNZlHSCSKmqEXuU1qx68sCNJpjJaeQfEz1KrmI18q/glio9jUBOvRFji
	 3PYdazWFgkk4KBosVCHGUyT4ZG83LxQQ64g7CFH2C3goAfckwi2bmii6IyReIcgZ1r
	 cBcarOhJfmGvA==
Date: Tue, 9 Jul 2024 13:11:43 +0100
From: Simon Horman <horms@kernel.org>
To: Justin Lai <justinlai0215@realtek.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, andrew@lunn.ch, jiri@resnulli.us,
	rkannoth@marvell.com, jdamato@fastly.com, pkshih@realtek.com,
	larry.chiu@realtek.com
Subject: Re: [PATCH net-next v22 00/13] Add Realtek automotive PCIe driver
Message-ID: <20240709121143.GI346094@kernel.org>
References: <20240701115403.7087-1-justinlai0215@realtek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701115403.7087-1-justinlai0215@realtek.com>

On Mon, Jul 01, 2024 at 07:53:50PM +0800, Justin Lai wrote:
> This series includes adding realtek automotive ethernet driver
> and adding rtase ethernet driver entry in MAINTAINERS file.
> 
> This ethernet device driver for the PCIe interface of 
> Realtek Automotive Ethernet Switch,applicable to 
> RTL9054, RTL9068, RTL9072, RTL9075, RTL9068, RTL9071.

...

Some clarification on my understanding of the next steps for this patchset:

I see that this version of  patchset has been marked as "Changes Requested"
in patchwork. So I think it would be best to post v23. And the only change
I am aware of is the execute bit of the source file in patch 01/13.

When reposting please do include tags (Reviewed-by, etc...) from previous
versions unless the patch has changed in a material way.

