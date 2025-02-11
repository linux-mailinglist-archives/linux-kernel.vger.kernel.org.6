Return-Path: <linux-kernel+bounces-510120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F0AA31866
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 23:10:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19BED18879D7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 22:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F33F268C7F;
	Tue, 11 Feb 2025 22:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="C4g1POY4"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4265267AF0
	for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 22:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739311837; cv=none; b=RmHts/MqvCyDqeyLL88nJjb7R75PJaCpXg6pjV3Zb5IZ5ZWsNWfKyHCxRjuaNRAwY7ReMrNB5QgzVmJJaUY51ESPrAVdO8xnQAXXgav3Br+9aFmMkEhp9m6OmZekssLAELbRrEWMD5SKceBO2bLmxUjpeoryQg+12eQP6UDK4Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739311837; c=relaxed/simple;
	bh=dJLZuoLMlEleOig6YUsbWp54n53y2F/uc4yu90VYmDg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K3EZD4NqkaARmmmZUPbPdOfAXVy5ZAfQuY/AZDYudGM/tZFjxBrUPxCr519+t3QeCfXrvj66Nr4ru1Rb1yqMqZYQ2PMA8MUndA3WoUD4gXQqKEatB1dfRtoal1FwmLxGnsvnZI+nfFpJJkjwGur57TjRGLXwAOkEhtwvCWE0+zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=C4g1POY4; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from thinkpad-p16sg1.. (d66-183-104-158.bchsia.telus.net [66.183.104.158])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3ABBD2107AB0;
	Tue, 11 Feb 2025 14:10:36 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3ABBD2107AB0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1739311836;
	bh=dJLZuoLMlEleOig6YUsbWp54n53y2F/uc4yu90VYmDg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C4g1POY4YcQbA0iUuMNksVwh7orPOS1Sb/+N6DFBc5PRDtZnIk5553sWhkj0Uwo6N
	 wXoBOwmYzkxDwk/r4h3Vx++VmAZ1aXnrG4ACJ6nnaxb2GlDypO36+FFNP/FVC9v84R
	 cja1uMdKq0257orrJgYN74ONAmuARlwT9PPDl5Y0=
From: Shyam Saini <shyamsaini@linux.microsoft.com>
To: masahiroy@kernel.org
Cc: shyamsaini@linux.microsoft.com,
	linux-kernel@vger.kernel.org,
	kees@kernel.org
Subject: [PATCH] init/Kconfig: conditionalize GCC10_NO_ARRAY_BOUNDS
Date: Tue, 11 Feb 2025 14:10:30 -0800
Message-Id: <20250211221030.1815731-1-shyamsaini@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241216072538.33280-1-shyamsaini@linux.microsoft.com>
References: <20241216072538.33280-1-shyamsaini@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Masahiro,

Do you have any feedback or reviews on this patch ?
Please let me know.

Thanks,
Shyam

