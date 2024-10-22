Return-Path: <linux-kernel+bounces-376229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA999AA1DD
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 14:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C476B1F22DF4
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 12:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A30819D8A8;
	Tue, 22 Oct 2024 12:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U3TlkF0I"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F9F19CD19;
	Tue, 22 Oct 2024 12:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729598809; cv=none; b=spsNg9zZMYNdFteZsgpzNNe3isZmi3fmIfbit3V9LH7IHyi/XP40YfiarEHNIk5bkN3+KxZYczrbn8gJm/g1Ro5U90bHrdvFtT1sy8ONnGNIRZ6v0eoaovS+h9CFsMtT1NbQmvslPLfjjtsv6Q+RBaeytKwvuWZ5PEIy1RhIk5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729598809; c=relaxed/simple;
	bh=vZySYiC2JdFzOl2i+o8PxtaWucEWcO5Yd7FP34d0fQs=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ctqxNWOmqDlu69X0CuU0K68J3WcRpA5jmf/8MuZVjZ8zHdc9jRmL285IIYJt6bq+uF1eWs/4duub0WxSCjmsYa+GxTA7xLLfsP+tbiiK/ug0zkSyt4K4AILs3OSPN2ALdVKOdRKKiInf2vnr0nC5dlhXE/ZgFo7usqNhoh7duDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U3TlkF0I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6455C4CEC3;
	Tue, 22 Oct 2024 12:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729598809;
	bh=vZySYiC2JdFzOl2i+o8PxtaWucEWcO5Yd7FP34d0fQs=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=U3TlkF0IQnvDoE6JkpU3bF9lMZIEhzYy1pc6VmHqr/eU1GXQVaBCFqNaDH+QKT//I
	 ulsxkqBSyAFilIgbzBv91+ButMPRrzAnc1jTi9iREXFw7bDrLeeFTxCxI/4iRkBkhs
	 pWq6PayEg4W+5C1KvXwoJFRPj1k3ojvswQqUV68D6XXp7s46khxDeswTfdgUr9oTmE
	 cIaJW5mhDIeKQ0iTkVW6xd05vv821rfORkTN7SnA1J4VPvjlYVyN/yPqDzwd0SXcej
	 Fwk7RuqwJ4SQftu+jOGAHiWlAWHEb55L+Gm/Q/CNYsM4ANhySJfS9R1k5BVnxTX3w3
	 ZuO+Wj7Xw0Vqw==
Date: Tue, 22 Oct 2024 14:06:46 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
cc: Sasha Levin <sashal@kernel.org>, torvalds@linux-foundation.org, 
    ksummit@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: linus-next: improving functional testing for to-be-merged pull
 requests
In-Reply-To: <53b980b3-6bdb-4331-a627-f6e775d23eb1@paulmck-laptop>
Message-ID: <nycvar.YFH.7.76.2410221357140.20286@cbobk.fhfr.pm>
References: <ZxZ8MStt4e8JXeJb@sashalap> <53b980b3-6bdb-4331-a627-f6e775d23eb1@paulmck-laptop>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 21 Oct 2024, Paul E. McKenney wrote:

> I have to ask...
> 
> Wouldn't more people testing -next result in more pressure to fix
> linux-next problems quickly?

I believe I brought up pretty much exactly this at this year's maintainer 
summit.

From the discussion it turned out the many people believe that this 
investing into this is probably not worth it, as it will require much more 
continous, never-ending effort (for which there are probably not enough 
resources) than just dealing with the fallout once during the -rc1+ phase.

-- 
Jiri Kosina
SUSE Labs


