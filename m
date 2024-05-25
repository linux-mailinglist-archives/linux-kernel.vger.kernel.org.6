Return-Path: <linux-kernel+bounces-189239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E50D8CED80
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 04:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1295828214F
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 02:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD2123A0;
	Sat, 25 May 2024 02:34:20 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618B710E6;
	Sat, 25 May 2024 02:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716604460; cv=none; b=iWT2hIH6n7f0rETV0uyj7M5k7OVuDXcdaNAh6/xj8rS8vKH7L/fowO0NVJvJ91N9un322tjLWBHtDJ8RY3XTUmTWi0fK/8X/C2VTAog8fAiE1xfqDIrjrImZ6KRaT9UyGBSJ9pRX30wB6v2H7mKn60rtCfd/U+bcxut3L1AG5XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716604460; c=relaxed/simple;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	h=Message-ID:Date:From:To; b=QvIC2lolH5nDfqdnjNfW2zJ8L4m3LYJnxHbsjpzh1O9ezxLRxCe++weaa24AWiftfZL+oUqzajYY2dlCgF9HKfFnwve1IANLBCIInM3XfLRtCGJ0l8wRXG/QrZvx/b2mwcR2kRhIeBChtJKVWs7E0ANazk5fXwlf5IOvyytw4EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1A42C2BBFC;
	Sat, 25 May 2024 02:34:19 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1sAhFU-00000007D6r-2UvS;
	Fri, 24 May 2024 22:35:08 -0400
Message-ID: <20240525023508.458244953@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 24 May 2024 22:29:48 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


