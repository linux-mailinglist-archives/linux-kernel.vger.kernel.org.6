Return-Path: <linux-kernel+bounces-400202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA6A9C0A41
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 16:40:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 249631F236A6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 15:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4A062139CE;
	Thu,  7 Nov 2024 15:40:18 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80DBC212D07;
	Thu,  7 Nov 2024 15:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730994018; cv=none; b=K+ktUs7NGM5DMXbuwtJLGK7St6ur0XW/liWFZswk+NpOiVLum1YPJUIRRHSjqa2YKg0mXTSLD3mcQwjlmbyUiVCkmFoU9cU/Bu11+4wxwe18myke/Oq91W06GXcuChhKCrjCOEABebnF1nMc89iKzvrgir/64hagwyZciHn8kHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730994018; c=relaxed/simple;
	bh=GN85DQ8GT3OLecMcZypUXFbyGyUxDPAtwS2VSzX9syw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZZAJAQhEkWE8KF+WCOJXbgEK2j6r12N9woi2NWSScSfEPsXpV47SSbLP1bx0Z8OvPRgs4UlgE8DWBtE9Rjc1fGbbfV+R0P/IjLTR8wfuokOUCSASFbI8mxW50rtSDpHYaUSdppn+EEO1RHpWEzGcI9JRYOp7eB6VsRRURQHU+Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73BE9C4CECC;
	Thu,  7 Nov 2024 15:40:17 +0000 (UTC)
Date: Thu, 7 Nov 2024 10:40:22 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: kernel test robot <oliver.sang@intel.com>
Cc: Zheng Yejian <zhengyejian@huaweicloud.com>, <oe-lkp@lists.linux.dev>,
 <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
 <linux-trace-kernel@vger.kernel.org>, <nouveau@lists.freedesktop.org>
Subject: Re: [linux-next:master] [tracing]  49e4154f4b:
 INFO:task_blocked_for_more_than#seconds
Message-ID: <20241107104022.47f2b527@gandalf.local.home>
In-Reply-To: <202411072207.b2321310-oliver.sang@intel.com>
References: <202411072207.b2321310-oliver.sang@intel.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 7 Nov 2024 22:25:23 +0800
kernel test robot <oliver.sang@intel.com> wrote:

> kernel test robot noticed "INFO:task_blocked_for_more_than#seconds" on:
> 
> commit: 49e4154f4b16345da5e219b23ed9737a6e735bc1 ("tracing: Remove TRACE_EVENT_FL_FILTERED logic")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> 
> [test failed on linux-next/master 850f22c42f4b0a14a015aecc26f46f9948ded6dd]
> 
> in testcase: boot

The commit in question does not even get executed in the boot process
(unless you have tracing on boot enabled). So I'll simply ignore this.

-- Steve


