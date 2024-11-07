Return-Path: <linux-kernel+bounces-400745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D22269C11B1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 23:31:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 895131F2511F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 22:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7024F212D30;
	Thu,  7 Nov 2024 22:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pissmail.com header.i=@pissmail.com header.b="q4c7XSoA"
Received: from mail.pissmail.com (mail.pissmail.com [173.249.47.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C7CEC0
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 22:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.249.47.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731018698; cv=none; b=DE206+wzWwBb8VzHME6/8v11E3t7RMYPmcNbKoVTm9NDAL97pSo0kgrsIPLGayG1Rv9qXbPxoKZrGPYVf7sWVMqHhms+fjml+KBK11d2QJnXNwTEgb9oWGX/OymnJxxso/1kz3O8VA/pqHMyXkoUgh7IRKsCN+9yqFIYvi9lvRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731018698; c=relaxed/simple;
	bh=+CD+TPpXt3lU4nxoxW3tMNT0OEn53ASawI0ed/NJeuo=;
	h=MIME-Version:Date:From:To:Subject:Message-ID:Content-Type; b=gtEMXjFZmtyBf7wyOI+cXRWqjDq4l1om9iM5nyo6p/YXeyKAl+3r41mXA9Ktsusr70P2TsN0tedItGEWGXF8Coh4sJSg5nxXssb949h87yv5iL5wCf1i42yLIMeHgNcbHScS/WxwWpEm7WpdAikyFAVG8YOq94Im1J3zCYjK5qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pissmail.com; spf=pass smtp.mailfrom=pissmail.com; dkim=pass (2048-bit key) header.d=pissmail.com header.i=@pissmail.com header.b=q4c7XSoA; arc=none smtp.client-ip=173.249.47.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pissmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pissmail.com
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pissmail.com;
	s=dkim; t=1731018334;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wbAgVkV20NZc2t1V+rliA3gwoLS+YbYAyFl1eZkVZgM=;
	b=q4c7XSoAtF0VrSZ6ufUfpF200PFlrDff3pYHDS/N/1Qro73bV3xyqpJQX1RhzpRAmpKFb+
	vo2byTyKxuabIyKatFxybCn28P25cV3gMJhjM3vm9uGuZrElLfAJVAa1CDu+Lt5NeTfQAQ
	WocIaM2uj+8Jc9FfNYCwDe3wkXdM0m2cnZQ2dIMwLY3iXEj6smV5d+bZkarXswOicGv3kL
	6yIBuUG48RBlWWCtY0TN2GqYYAa/bC5LCIo3yF5ErrN2RsSvMBVhMqeVMU64BUNWS/N9tC
	3M5p4CMIrdjkBNA5fS9J2191IvSduCuOwb/0DIv9IO2tf7SKRao+rODXy2dpbQ==
Date: Thu, 07 Nov 2024 22:25:33 +0000
From: mortodenoite@pissmail.com
To: linux-kernel@vger.kernel.org
Subject: Richard Stallman on the removal of Russian Linux maintainers
Message-ID: <a52180ee7fe5ab1e55fa549d0391e019@pissmail.com>
X-Sender: mortodenoite@pissmail.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Bar: /
Authentication-Results: mail.pissmail.com;
	auth=pass smtp.mailfrom=mortodenoite@pissmail.com

[[[ To any NSA and FBI agents reading my email: please consider    ]]]
[[[ whether defending the US Constitution against all enemies,     ]]]
[[[ foreign or domestic, requires you to follow Snowden's example. ]]]

Free software calls for giving people the freedom to cooperate.
That means a group of people are free to cooperate when they all
want to cooperate.

But that is not the precise requirement.  That is a consequence of the
requirements.  The precise requirement is that users be free to make
and distribute copies of their modified versions as free software.

Those Russian have a moral right to distribute copies of their
modified versions of Linux.  But they have no moral right to demand
that the Linux developers _use_ those changes.  Whether you use
someone else's changes should be up to you.

-- 
Dr Richard Stallman (https://stallman.org)
Chief GNUisance of the GNU Project (https://gnu.org)
Founder, Free Software Foundation (https://fsf.org)
Internet Hall-of-Famer (https://internethalloffame.org)

