Return-Path: <linux-kernel+bounces-416478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E01139D45AD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 03:12:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E61F1F22570
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 02:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E8A70811;
	Thu, 21 Nov 2024 02:12:20 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC3039FCE
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 02:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732155140; cv=none; b=JGCUpIEuYAfKVBKjcXdDnqpJrLHuc4YoQo0CdVoCu+4fDwSSfOGz5t7+4Og3gHuMd1obFqCudiyARGgBKn2pdDJAKch2a4Z38VIHtIL3NhZpi2t7WD8LImTWse/N/uPK7wirKRTDaHhUp65N8H8WEsT9ZbwGjdLMBtWtAVHlMf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732155140; c=relaxed/simple;
	bh=J8unRYiUdLCWYS5YDaz6lQKCpgJfUMrBzo9K4kxrh8w=;
	h=Message-ID:Date:From:To:Cc:Subject; b=C8az8BnQDmSK4LejeRjJP1Jpbdu3bqs8FZz7APVPUF6w24WuOobaokL0mvxjP6Y/+jycMkUq4qrbenc6K/dNjvL4QQvtMkn+5FQ8Ujz96BtJUc/uY48h97m47JqAHghSjlj6DacRAiuzc0OcPF2Df9B+ucQ9xRDseM3AaIr1tTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E728AC4CECD;
	Thu, 21 Nov 2024 02:12:19 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tDwgj-00000002ZhH-0gym;
	Wed, 20 Nov 2024 21:12:57 -0500
Message-ID: <20241121021226.575757843@goodmis.org>
User-Agent: quilt/0.68
Date: Wed, 20 Nov 2024 21:12:26 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 0/2] tracincg/rust: Last minute updates for v6.13
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
rust/for-next

Head SHA1: 8af7a50167833b6b22e30c008bbf95ab3ff1a5fb


Alice Ryhl (1):
      jump_label: rust: pass a mut ptr to `static_key_count`

Miguel Ojeda (1):
      rust: jump_label: skip formatting generated file

----
 rust/Makefile                                                       | 4 ++--
 rust/kernel/.gitignore                                              | 2 +-
 ...static_branch_asm.rs.S => generated_arch_static_branch_asm.rs.S} | 0
 rust/kernel/jump_label.rs                                           | 6 +++---
 4 files changed, 6 insertions(+), 6 deletions(-)
 rename rust/kernel/{arch_static_branch_asm.rs.S => generated_arch_static_branch_asm.rs.S} (100%)

