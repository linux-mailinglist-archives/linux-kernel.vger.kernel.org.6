Return-Path: <linux-kernel+bounces-359582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35C85998D91
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 18:36:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6141E1C238E1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 16:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF671957E4;
	Thu, 10 Oct 2024 16:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dGWqA8hF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8F51953AD
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 16:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728578163; cv=none; b=bNUhjS66xB+bQBACe5GqLtT8EsKfdbIgfP3w6zaKd7bnqGs5/EGQ6IPT9GKCs+yc/X2PLZJ3RsLOMr2wIIMwPEQdICm/Xf5vwMRL1ZoJ84Xd1ByR3bBl3a1+yQi5aaDZewF/VjsGiFPNhzHUdexf1cR+aoF0LeYg5iZ/ZqcjTdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728578163; c=relaxed/simple;
	bh=5q9bdWcF/uDstrjX4xGgD6gUZboSJxZvKbDvle2AsRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NbD9FB4V/zM/lBVOKpdvycAbUTTAgPuexW/DVQAVgOdvg0iTsbNzynNphGbOjmCah6bNX/Amjw6tmkp7boh4IW5gBPyoBXhkIrFcgrp5BlUvAZv6XBftybwoxJZnI8OfVJc4eyYvms43peeJPbg9gNEJfMEd2UXk4fzeEhe59fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dGWqA8hF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82AD9C4CEC5;
	Thu, 10 Oct 2024 16:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728578162;
	bh=5q9bdWcF/uDstrjX4xGgD6gUZboSJxZvKbDvle2AsRE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dGWqA8hF7dZrdyj/maXqkj3MSKVUCOTwqPumf+hDi6ZBkWLJKP6MW2q/j8lETxzb1
	 KmPdFuY4IOVw0qFDztOWBoxDJdyHYt7b/v+fMsEei3CIObY/hYYDTGZtGcqB8vpfvw
	 KidupRDw6kRoQq/G8PtUWyW+6aUcTKatRPHqUvpMWa2knIw8cXWXJcYJEqj65+vOI7
	 Lo1TeILCiQ8opaj8SxSOsjMa0B6mZsTu3JWMq89EP/AdG0XHo5dgv5iqd0W9TyP+B6
	 VluJglNFvRBli7Yzf5Mu6vuklHRwgqGL69o4hrY27fhwIpmn2/5zqORS60sgskKZ03
	 6YPoaPVQMwwBA==
Date: Thu, 10 Oct 2024 06:36:01 -1000
From: Tejun Heo <tj@kernel.org>
To: Honglei Wang <jameshongleiwang@126.com>
Cc: void@manifault.com, mingo@redhat.com, peterz@infradead.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched_ext: use correct function name in
 pick_task_scx() warning message
Message-ID: <ZwgCce2o5fqPOwEx@slm.duckdns.org>
References: <20241010033405.72313-1-jameshongleiwang@126.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010033405.72313-1-jameshongleiwang@126.com>

On Thu, Oct 10, 2024 at 11:34:05AM +0800, Honglei Wang wrote:
> pick_next_task_scx() was turned into pick_task_scx() since
> commit 753e2836d139 ("sched_ext: Unify regular and core-sched pick
> task paths"). Update the outdated message.
> 
> Signed-off-by: Honglei Wang <jameshongleiwang@126.com>

Patch updated in tree.

Thanks.

-- 
tejun

