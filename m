Return-Path: <linux-kernel+bounces-345863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D6C98BC16
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 14:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA01328478F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 12:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 530D31C2436;
	Tue,  1 Oct 2024 12:29:55 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4631C2424;
	Tue,  1 Oct 2024 12:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727785795; cv=none; b=GlFH0nVwA/uCeUO04WwhSSgBVxShybO6mhL5WPGjQt9ozTRnOjBewfWdDTTcmGfPCV2PLsDwDOt/10qq773h8t1wV23jRfh7qMMkR97S7z5DsaQkBnS1OVC/itbx9O+JalAsA9YuuVettM2LEk0QwnPa2LqCJ8qYI7KdaCG+s8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727785795; c=relaxed/simple;
	bh=JfwHqGpu9TO7VwbUdNhKeCu3aGNCFV16+/kIFIdtKPs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CeLYRk+OKdS1gr4HHzEBJBiOu0bLKksavTiHrSOaZD/721zzW6hmZrTapiFmfYZ0h0WkcxBKdjoH2P8hTviXGA3ezmiRjbQJNY11RW1tUNXlFPFa8LzX4pB5DNqhP/53rf3+0sI9JFSfWPoQ/lA9ksadZ8Trw0QaL2UphFSP30c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3824C4CEC6;
	Tue,  1 Oct 2024 12:29:53 +0000 (UTC)
Date: Tue, 1 Oct 2024 08:30:42 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Question about config UPROBES and UPROBE_EVENTS
Message-ID: <20241001083042.12f388e7@gandalf.local.home>
In-Reply-To: <10d33d7f-5785-93e1-128d-5ad6ac2e771f@loongson.cn>
References: <1a3567d5-e558-351a-c45d-73b2e5a8788c@loongson.cn>
	<20240930081529.f6f9161c20db9b95c9b46252@kernel.org>
	<f639079e-bc1c-7f2a-4c3f-de1a6780da84@loongson.cn>
	<20240930100630.7894c442@gandalf.local.home>
	<20241001002813.6012587b5e52737a576f1d0b@kernel.org>
	<20240930113231.6c87108d@gandalf.local.home>
	<20241001004307.bc238bbda81907c08a8c1e96@kernel.org>
	<10d33d7f-5785-93e1-128d-5ad6ac2e771f@loongson.cn>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 1 Oct 2024 14:30:33 +0800
Tiezhu Yang <yangtiezhu@loongson.cn> wrote:

> Then, CONFIG_KPROBE_EVENTS should depend on or select CONFIG_KPROBES?
> In the current code, CONFIG_KPROBE_EVENTS depend on CONFIG_KPROBES,
> the CONFIG_KPROBE_EVENTS menu is hidden if CONFIG_KPROBES is not set.

We could just for consistency. KPROBE_EVENTS would then need to depend on
HAVE_KPROBES as well. It does add some duplication.

-- Steve

