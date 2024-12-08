Return-Path: <linux-kernel+bounces-436512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAFFC9E86ED
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 18:04:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35D1A281470
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 17:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 475DB1990BD;
	Sun,  8 Dec 2024 17:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VRzEtejj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3E6198E76
	for <linux-kernel@vger.kernel.org>; Sun,  8 Dec 2024 17:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733677418; cv=none; b=pPqWtDSYI8sEVTWYbOdRnjSvk8eQKrjWgCdujfYGmJX2i5jGDE17xz0/mCVE8QtFli21+E9ts+lTpROKUCtwb24fKOxGwcl4eCeaUsN/dKKeVpF2EMdrX/RFeo8OCD1+7KyfvEYemZjGFvc1eTbw9wYOuuk8MK0W3FX09sN5TXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733677418; c=relaxed/simple;
	bh=wZtQx4LbWSSY/m3QW/D7okTuQMfDvyrzXVuuIlkX6kQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rLmLDibN+rC+Y6IM+iCkEIIiazKNTDcykRHMP2HmZaqiTZIl+0nyhnMl3dXVzv8RX/O6YGjEbAYeegCK9nKwOmc+sRN45lMCsVHR1CfNS7GupoR6EhZ1kWwQZPCbTIv6WGVFfmZkZULCkdHSRGPRdGD+gk/ehz1vGb/FCl9kuBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VRzEtejj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3809C4CED2;
	Sun,  8 Dec 2024 17:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733677418;
	bh=wZtQx4LbWSSY/m3QW/D7okTuQMfDvyrzXVuuIlkX6kQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=VRzEtejjJbPuAp3DzWKUycxKEnDUvtHOiWF11H6Hnbuy7JLDq3l1iONkEpirH+4l+
	 ozzK1mxXBwz77NTxbvhbFLE+AtdDrKW2rtuLyW10tm7tlHP651JOUQeydy4Ulj1XUN
	 w2thzoclFYyZYFDyTQ91HAYqzGpJfX4zzhMHiApFwtUUefWWJdenyf3gTPGjwNz3Lh
	 oQV6G2r1WqaFLGs3caQjw8Pq3yc5zVZQxhJiVx/NyLu7uoQO+hf/L+faQDTjX3Chnn
	 pf9rsG80cou41mbwlG5crZW3n56fYMA1iQObiJSTJ3jaXfhgcn61EaF3Y8rSwM0K9E
	 dVwdyd5RfLvTQ==
From: Vinod Koul <vkoul@kernel.org>
To: linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Kishon Vijay Abraham I <kishon@kernel.org>
In-Reply-To: <20241031104401.2454179-1-andriy.shevchenko@linux.intel.com>
References: <20241031104401.2454179-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] phy: HiSilicon: Don't use "proxy" headers
Message-Id: <173367741643.1042266.13809719892889387610.b4-ty@kernel.org>
Date: Sun, 08 Dec 2024 22:33:36 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Thu, 31 Oct 2024 12:44:01 +0200, Andy Shevchenko wrote:
> Update header inclusions to follow IWYU (Include What You Use)
> principle.
> 
> 

Applied, thanks!

[1/1] phy: HiSilicon: Don't use "proxy" headers
      commit: 80738c3f1e1b7bd664481d73d64e42e139c7002d

Best regards,
-- 
~Vinod



