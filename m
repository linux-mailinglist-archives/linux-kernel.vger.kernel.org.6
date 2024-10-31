Return-Path: <linux-kernel+bounces-390697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F1079B7D79
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 16:00:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 245122811A3
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 15:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 233CA1A3056;
	Thu, 31 Oct 2024 14:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PVd5Ixm6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8316319D899
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 14:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730386788; cv=none; b=QhwuTrSCcDkAwm6jk9IRGgZG11+LxYFM6HuPcmp0tu2UPIb2tD7Uw9Ph5JlXNQ6LuUOf+usKjmLsyFfU5t0ZmUPo27oXIr/vB78ZfQD5TGCwaB7D7fnw2CDcqSiC3xvGpYO0gsVSrhTysP8sl5CbfwNbE7ublcJjxxIfLDoEtfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730386788; c=relaxed/simple;
	bh=FFmQ1JHNHn/xiIla3dEgbhTtdnSwKyO09XwWOiUvx4E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=KahAbKnjeDyf6cqy9+fxAZJQZrITozEYWhbAKtzP2zmdjmoTspgwL8Rpem7OUpE6o9DnH5IoOm4QasyRmGlTxpVMgUqdEdV1lRx6VH0OcYyjRzjMzgG7ZYaMWlbAGQY/cwqWAddVXUy9GBVzAWl0ZAtCQzFgQqtSG8NhYVM+rqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PVd5Ixm6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5166DC4FF63;
	Thu, 31 Oct 2024 14:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730386788;
	bh=FFmQ1JHNHn/xiIla3dEgbhTtdnSwKyO09XwWOiUvx4E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=PVd5Ixm6Ch1TJHLQJ1QOdA/ma0AT3rq+6oymJLflYH5rfWuR7rgmZJ7vHYhSUNs7E
	 wb71IcWvMyZC1TMqxUXHK5XxmCzOTfBOW2XFd0HuNox5rtuqW3LOFHT+EJRiW59DW/
	 sU7D8gRM6AefvzTnzpeY/B8mI0QVbaqpWqlM7g3V9SkG00aUMXQytIX9tUHkuNL857
	 dNZRMp5Mw048WgEin457LHlrs+jcPb2QafhFzaG+ZaORy+ssHfnfyniyiF5Vic7lvD
	 1MlAQehvoskep2aTWlcp3UZ7uUIV05Xu50cvUkPoFGQt32EnrPIN4lNVheUh9jv60D
	 UqYiYruBF/1tA==
From: Lee Jones <lee@kernel.org>
To: linux-kernel@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Lee Jones <lee@kernel.org>
In-Reply-To: <20241016130023.872277-1-andriy.shevchenko@linux.intel.com>
References: <20241016130023.872277-1-andriy.shevchenko@linux.intel.com>
Subject: Re: (subset) [PATCH v1 1/1] mfd: ipaq-micro: Add missing break for
 the default case
Message-Id: <173038678706.1764347.4740781144807850497.b4-ty@kernel.org>
Date: Thu, 31 Oct 2024 14:59:47 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13.0

On Wed, 16 Oct 2024 16:00:23 +0300, Andy Shevchenko wrote:
> Even default case should have a break statement to make code robust
> against changes (e.g., adding a case after the default one).
> 
> Add missing break for the default case.
> 
> 

Applied, thanks!

[1/1] mfd: ipaq-micro: Add missing break for the default case
      commit: 3d1c3272a80952617158a9149bebcebb4463a4fd

--
Lee Jones [李琼斯]


