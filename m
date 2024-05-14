Return-Path: <linux-kernel+bounces-178939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE8EA8C5995
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 18:18:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A81961F23AF6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 16:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC0517F383;
	Tue, 14 May 2024 16:17:07 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133D917F361
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 16:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715703427; cv=none; b=e4HhTVXYEmNHS1nwM8rlaZuLxWBCEgeoWH7L2ov/zxxOur64qDI3kVhwGhlzZrUUOpiXTu6NWjSZvK5H9kfyQ6LxAEqk21YPkQVyspbhDWCDzYbNFrKa9bEboRcqhyeEr1GIyxkb4B2w8HadIIkEZHTifncIip+wkvk1xl6jNzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715703427; c=relaxed/simple;
	bh=+ldzOS7+fN2OTofOEtbsAWwDCRGjMLDuQNhPLS527KI=;
	h=Message-ID:Date:From:To:Cc:Subject; b=hz6rAEcGRiGE75eGDDy9jWCg4uagI3n1OQPGO6d4jBHo3EnIcNU4bW7BOXtE+0So6lzsLNrdlKLX8KYX6OX4dmqMAJ8phrfOZM4JipXHNU2mUM4cUSSjxTjIRv4Dxq37ZTPKuDXFrtADZmk2udgWjZBdKW7tFdz3sgOodyqlZ54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E52F9C2BD11;
	Tue, 14 May 2024 16:17:06 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1s6uqJ-00000003tJ8-2Z4J;
	Tue, 14 May 2024 12:17:31 -0400
Message-ID: <20240514161710.977621701@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 14 May 2024 12:17:10 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 0/2] tracing: Updates to user-events
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
user-events/for-next

Head SHA1: 78490b74435a8c738e91260e7df387e7cb6d6568


Beau Belgrave (2):
      tracing/user_events: Fix non-spaced field matching
      selftests/user_events: Add non-spacing separator check

----
 kernel/trace/trace_events_user.c                  | 76 ++++++++++++++++++++++-
 tools/testing/selftests/user_events/ftrace_test.c |  8 +++
 2 files changed, 83 insertions(+), 1 deletion(-)

