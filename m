Return-Path: <linux-kernel+bounces-366793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3203B99FA7D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 23:48:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCA461F214F3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 21:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6511B0F37;
	Tue, 15 Oct 2024 21:44:56 +0000 (UTC)
Received: from mail.aaazen.com (99-33-87-210.lightspeed.sntcca.sbcglobal.net [99.33.87.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C6D1B0F1C;
	Tue, 15 Oct 2024 21:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.33.87.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729028696; cv=none; b=Jhdp5lvBiHRgYESmDDMRuK8upkvNzDlV+Wd7rKgQ4f96Xo0Hx9VSDhSF6Y8qkZ4dK8jH9AU4oeyQYs//rJRjEB3hLoljOxZhO7cKpOMqPhszDq+7Zf9H5qGkhU7E6/2PaYXlUCP3jOiKD/fQh6g9Xtx775RyeLtkWqVs1kT+Qhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729028696; c=relaxed/simple;
	bh=suzL021ArH8NPBqVpYZtfnGOOFnNy7Aan+tLyjhKjh4=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=kqhdAW+JBDJnUhAmcH90Zx1EZIN7dg8x2KVvD3J/GjlLRjzopNGxh0oRUWQjx4pJWSsMZzN/DOjH2UJTPKOLW4PPK0SziVLjFVgN1RGy8LiXD0NnvsHQNvU7GBRXBNtvT5vHXgkXNxln+vmVJbYX0XP7K2o9a/cdcI60Z3+GgMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aaazen.com; spf=pass smtp.mailfrom=aaazen.com; arc=none smtp.client-ip=99.33.87.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aaazen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aaazen.com
Received: from localhost (localhost [127.0.0.1])
	by thursday.test (OpenSMTPD) with ESMTP id 44e3bc58;
	Tue, 15 Oct 2024 14:38:13 -0700 (PDT)
Date: Tue, 15 Oct 2024 14:38:13 -0700 (PDT)
From: Richard Narron <richard@aaazen.com>
X-X-Sender: richard@thursday.test
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Linux stable <stable@vger.kernel.org>
cc: Linus Torvalds <torvalds@linux-foundation.org>, 
    Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5.15 000/691] 5.15.168-rc1 review
Message-ID: <e0acaa55-2e49-e8f-4a9-ceb75caf5337@aaazen.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Builds and runs fine on x86_64 and x86 (Slackware 15.0)

Richard Narron

