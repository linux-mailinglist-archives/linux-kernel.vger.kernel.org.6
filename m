Return-Path: <linux-kernel+bounces-254537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB8D933476
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 01:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DC701C22347
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 23:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67431143C46;
	Tue, 16 Jul 2024 23:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DT4AGKT9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA11C2AE6A
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 23:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721171434; cv=none; b=VRcLsiBBPE1qzGe7p58TBmSmm40x3aoZdYHPIUqGZqvtkwrztpydBTdawNhmTnMJ0Q8m/Qy64eL25ew37x8HN0VDoTISFcOL34D/olNT3qmzKs2PPJxmyEaPKUlbdrvbfVoIdjtU72XqnFMO6zykmdTUVlB5oKmPlJofmUqSjY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721171434; c=relaxed/simple;
	bh=blz4Z4QKskuUYuCvow8IAsAbXnkc4XtUv9s9LqTDze8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QgxRykTtAAqb/9701Ym/BZq4rUyw7N6BO9vTtVrZDa+7OhdVKqpUAg0Zhb2SQCj5GboxeeoUJcTliOyKnKDGQiY4kjh051AAcJvy4Ji1GvpFAXTtBJz0gWhZAh2LEmwyn0inqlTuvoil8+QpMFMF43olJDJTby8lQA/OiD8xlLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DT4AGKT9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D75FEC116B1;
	Tue, 16 Jul 2024 23:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721171434;
	bh=blz4Z4QKskuUYuCvow8IAsAbXnkc4XtUv9s9LqTDze8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DT4AGKT9Di9Inn4LLhtLQlJSkTTkBguQMkxFAdg7Y+6t7FU1vg5A8MD6OUllYDxl0
	 hqMIFwQjQYkhusJCM3OC5mzlTPu4q9+de3wB82M73OZH2H+YTkRUj9Qw1mSsm1tGHD
	 bkmh9hflZ4Kd0lkn6lIi7ZidNkTWk8an9AY/RJ48e/fjm48eqhlAhtLccjHne8XUlc
	 SPTTaQi9DSowSyL9b3PeJjao12u+JRsF+dowlVB81R6voO2bGPtND7yZEGkjImbOnG
	 E9JLUMJriJqWhT4QQceukcSHbf6CJxwhqQw5TfEVfk7I9CzJEANurAqcJ8rl856M7U
	 onGYzjl5w0LMQ==
Date: Wed, 17 Jul 2024 01:10:31 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 6/8] timers/migration: Rename childmask by groupmask
 to make naming more obvious
Message-ID: <Zpb9520N-4wLczUO@pavilion.home>
References: <20240716-tmigr-fixes-v4-0-757baa7803fe@linutronix.de>
 <20240716-tmigr-fixes-v4-6-757baa7803fe@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240716-tmigr-fixes-v4-6-757baa7803fe@linutronix.de>

Le Tue, Jul 16, 2024 at 04:19:24PM +0200, Anna-Maria Behnsen a écrit :
> childmask in the group reflects the mask that is required to 'reference'
> this group in the parent. When reading childmask, this might be confusing,
> as this suggests, that this is the mask of the child of the group.
> 
> Clarify this by renaming childmask in the tmigr_group and tmc_group by
> groupmask.
> 
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

