Return-Path: <linux-kernel+bounces-261682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E2D093BAC4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 04:28:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1E8B1F23291
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 02:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6A1D299;
	Thu, 25 Jul 2024 02:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r+goUH0s"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9084A6AC0
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 02:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721874483; cv=none; b=hGvcnHnv9gt3GbvNWJ5FRMX80koxQ/S7cdozAmwKwV+cBNHwVHWN1vuyujEda34+diNtHBF9/WZk2wbpUsNRh4haWrOa7aOCmp0UJV+Kp2nAb0+VAAn5ZMe+rRWlc+FutUboW9vvH5J8MEMbjNdamFapCDS+wnRq0BCdl0bgrfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721874483; c=relaxed/simple;
	bh=oQgEv43BvjlKK28svpwUJB/JCTTe8M0XQ4zcDBGE5aY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cGkAIc4EUjyLWeCD4ZTaIodeBgWZdHwBCjel0M8bTsaCtwixIDHcE1WaQk9n1hyl5f+NL8X3FjlvvtL20FN5ZD/ffSlSeGdhlZQAQ61kPV/L8yFbuf/hVstis1gspTPiie5D3ruqpb01uQ4axLnMODfhIeIqHxqB5gdWTmjowXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r+goUH0s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3D4EC32781;
	Thu, 25 Jul 2024 02:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721874483;
	bh=oQgEv43BvjlKK28svpwUJB/JCTTe8M0XQ4zcDBGE5aY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=r+goUH0sSeeQqlbmHzZAHpxfJZ4UPI5bjb5beOICAyGHFOS1YLPI1gQpsxmo+Z3Wm
	 LfJUPDcmQfwpYLAp8OxV5plBWIJ1RXwVIxgXRd97YzfJyU8pModWzQhaRlKLfgVb7C
	 mZ1pd1+f/DZ5T5bbG8RAOPVC0uvALQAnDdgqXNlm6KarjvQcLjK3LNe3tpkTSib9e0
	 saKutSo+OqgvxknOKHL7wDJsX2AMABOe4c5vX8PyInPcIaqPanowx4pRLduPPAfZv1
	 tGJxvSz6DA4wMiKMGNz9cgPHhqwWA5KOu2M3K4YHrpjDZDgQ7Q2hlM0RZ/Ip57EVYm
	 /j7Ycs5Ti56bA==
Message-ID: <fc034a35-0dd5-4233-91f2-19734bc87559@kernel.org>
Date: Thu, 25 Jul 2024 10:27:59 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] libf2fs: add BLKFINISHZONE define if not defined
To: Wu Bo <bo.wu@vivo.com>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 Wu Bo <wubo.oduw@gmail.com>
References: <20240724102818.2665047-1-bo.wu@vivo.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240724102818.2665047-1-bo.wu@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/7/24 18:28, Wu Bo wrote:
> BLKFINISHZONE may not defined in old blkzoned.h, and cause build error.
> 
> Signed-off-by: Wu Bo <bo.wu@vivo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

