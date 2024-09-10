Return-Path: <linux-kernel+bounces-323852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE7197443C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 22:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93CEE1F24196
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 20:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D30B7183CC7;
	Tue, 10 Sep 2024 20:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bj137+Hj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E977183CB8;
	Tue, 10 Sep 2024 20:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726001067; cv=none; b=r2A0z09u/Xl2/mXy8IMdxubWgk0eZqfjN/hBU7T4agYaaMwcDq7MPtlJBi0hqqIVPD9ysTEGbY88cdvaNwnRZ0IhdjpYhcj5V6K/vYA/cF/zreR99dSYic0wKZ7ZKQEj2ZdRZPi+uzR4EbN2ozt4f6Qxz0U4JcDClNY9mqkLLfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726001067; c=relaxed/simple;
	bh=5iGvupN4Fv6ShBnl19IBb12j7KDyopKR9KZCk7Rfeyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JCDNLukwvCJ1qxNy8hbeouYSh2VEd5YWIIlYjRUnB+EWc98vR+KLB78P4SYwbUeUI98q24qrPid/3yltbaxO1I9NGDPH1hl8OmAOjui3yi2lplvC112BrbWZA0fdwtgiR4OBvECT7tk8cC4BDW62BNMTVjGQrOD4NIwNFDU27jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bj137+Hj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF7B9C4CEC3;
	Tue, 10 Sep 2024 20:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726001067;
	bh=5iGvupN4Fv6ShBnl19IBb12j7KDyopKR9KZCk7Rfeyg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bj137+HjIWCMqWIHRKBZ1KmMTzNB0Qo4+vCp3pLxOq193C4VGEDLTRPfMGxR38ZGH
	 fZoiCHU8olVbyrNM8bG9WX2EWDnkxd/YjBX5EWByyOU/qvjvknt+0Efu4p1ObN7jIe
	 cvKZKkKLG0C5p4cdsAd43Em97kf4mhCdKMDkRmdcyduJF420FHmmwHSQQOOHYsqjbE
	 QHynkViO+sXzJWYifduscKpirT3WAQDXn9Ea/uzxv4Wk8FCpkvsDjnR/PVk19pxnIb
	 3eCZblCfU3XRIRRqJ2dsCtSwiXcuUkMgja0ZwXlXri8VG7TXPnQhjGtQmP3gkofsfO
	 g97E3Wbwgn7DA==
Date: Tue, 10 Sep 2024 15:44:25 -0500
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] dt-bindings: trivial-devices: Clean-ups
Message-ID: <20240910204425.GA713411-robh@kernel.org>
References: <20240903-dt-trivial-devices-v1-0-ad684c754b9c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903-dt-trivial-devices-v1-0-ad684c754b9c@kernel.org>

On Tue, Sep 03, 2024 at 04:52:04PM -0500, Rob Herring (Arm) wrote:
> This small series drops some duplicate compatibles and fixes an 
> incorrect vendor prefix.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
> Rob Herring (Arm) (4):
>       dt-bindings: trivial-devices: Drop incorrect and duplicate at24 compatibles
>       dt-bindings: trivial-devices: Deprecate "ad,ad7414"
>       dt-bindings: trivial-devices: Drop duplicate LM75 compatible devices
>       dt-bindings: trivial-devices: Drop duplicate "maxim,max1237"
> 
>  Documentation/devicetree/bindings/trivial-devices.yaml | 15 ++-------------
>  1 file changed, 2 insertions(+), 13 deletions(-)

Applied.

