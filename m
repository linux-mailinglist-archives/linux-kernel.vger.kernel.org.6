Return-Path: <linux-kernel+bounces-390998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E6DD9B80F9
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 18:16:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACF051C21F62
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 17:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8620E1BE87C;
	Thu, 31 Oct 2024 17:16:09 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C31194C6B;
	Thu, 31 Oct 2024 17:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730394969; cv=none; b=rLF/i3VmqYQbZSL9o1pFQ6rwc8bONilNsjFi1TLInHztQbGWtmCi8PIcZpuN5yYf95Klgd8zDZw+MXQwHZRejuyCbLJZA9vYSbRMIpxZoOByrHzZSr6VzhQMCAloFZNN313cVgAB3BNLyK9bh0YbFdRv1WZOxFo/QubJe1vYRV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730394969; c=relaxed/simple;
	bh=005xkjtnlU6oyk/+0nHfJS1oRRgb6Ml20SVYLTsG7yc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WsVzu1ThemlDdKsyipMAeL3Yw4mr2ZtqhUIF9ia8A93ghAjhfLlslob/CEnDO1IEYjrZX2sBRrgFoC6nFrFfs4Ys9VnsaLY9xir1eQ3SLkLY+iE4l5ZnYqvH44T27KFjtSnpt1AXyoPkQjHW4H7O4h92zTaYBB0IlBzeib6uvn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 23D1A1063;
	Thu, 31 Oct 2024 10:16:35 -0700 (PDT)
Received: from usa.arm.com (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 91A933F73B;
	Thu, 31 Oct 2024 10:16:04 -0700 (PDT)
From: Sudeep Holla <sudeep.holla@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org,
	Cristian Marussi <cristian.marussi@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] firmware: arm_scmi: Reject clear channel request on A2P
Date: Thu, 31 Oct 2024 17:16:02 +0000
Message-Id: <173039475222.3108069.291513539121527165.b4-ty@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241021171544.2579551-1-cristian.marussi@arm.com>
References: <20241021171544.2579551-1-cristian.marussi@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 21 Oct 2024 18:15:44 +0100, Cristian Marussi wrote:
> The clear channel transport operation is supposed to be called exclusively
> on the P2A channel from the agent, since it relinquishes the ownership of
> the channel to the platform, after this latter has initiated some sort of
> P2A communication.
> 
> Make sure that, if it is ever called on a A2P, is logged and ignored.
> 
> [...]

Applied to sudeep.holla/linux (for-next/scmi/fixes), thanks!

[1/1] firmware: arm_scmi: Reject clear channel request on A2P
      https://git.kernel.org/sudeep.holla/c/a0a18e91eb3a
--
Regards,
Sudeep


