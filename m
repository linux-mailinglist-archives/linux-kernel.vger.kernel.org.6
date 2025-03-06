Return-Path: <linux-kernel+bounces-549178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0123FA54EA0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 16:12:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 664C57A9AE8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 15:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A61620E03A;
	Thu,  6 Mar 2025 15:12:04 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56AC20D4FE
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 15:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741273923; cv=none; b=L1ns+y4uhvtvCA45gLqqEgshmds1alPTrogK5wolSDpn/WEb93Qjqbps25/gHDnOjYfnLViSA8+Ez8GjH0WuNgfcH0DL0BwYZdoKGTvP/c/zmZ7RZBI9y4Y7AjaS83gHGx8SKb4+WhHQLlZEa8SQmWqgSPQXKllrMvvqalhDabI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741273923; c=relaxed/simple;
	bh=+idBqcRZOiikevDBFbhfVc+O9nvamrtZ33r8uDUTUyk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t9cZjILretXbC4fxQlpiwkrCCSInba7MsmCcXhrYktl6+SeHR9iBcU7PECAhmzI4bm5qXsVRwNKrW6mRlDAvaOmFd5G03lA0pnXsyMrLmz228vm31vhWVHlu9Dhw8Mi7No/01Skf79CEyFR4bGQyoQW/SMFhkAnFW6QtdfX7VZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B15D6C4CEE0;
	Thu,  6 Mar 2025 15:12:02 +0000 (UTC)
Date: Thu, 6 Mar 2025 10:12:03 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Jain, Ayush" <ayushjai@amd.com>
Cc: Ayush Jain <Ayush.jain3@amd.com>, warthog9@eaglescrag.net,
 linux-kernel@vger.kernel.org, srikanth.aithal@amd.com,
 kalpana.shetty@amd.com
Subject: Re: [PATCH v2] ktest: Fix Test Failures Due to Missing LOG_FILE
 Directories
Message-ID: <20250306101203.3a131a57@gandalf.local.home>
In-Reply-To: <7bda5c5c-3f2e-496c-b5a0-6f7d9120dacb@amd.com>
References: <20250305041913.1720599-1-Ayush.jain3@amd.com>
	<20250305190159.7c590242@gandalf.local.home>
	<faadd6ad-3b85-4ad3-8d17-acb5e0991a18@amd.com>
	<7bda5c5c-3f2e-496c-b5a0-6f7d9120dacb@amd.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 6 Mar 2025 10:19:04 +0530
"Jain, Ayush" <ayushjai@amd.com> wrote:

> Just to be clear on my end, you mean 4 space wide tab for indentation here.

Correct. That's what the rest of the file has.


....[indent 1]
\t[indent 2]
\t....[indent 3]

Where . is a space and \t is a tab.

So for every 8 spaces, use a tab, and then add 4 spaces at the end of those
not divisible by 8.

-- Steve

