Return-Path: <linux-kernel+bounces-193527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ACAE8D2D71
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 08:41:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BDE61C256AB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 06:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F82D15FA9E;
	Wed, 29 May 2024 06:41:16 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126B915B122;
	Wed, 29 May 2024 06:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716964876; cv=none; b=S/CE9qnuxWNWXnSFvffhU+jRwhXucCsVMTPi5QOlq5oSC9Zw1mwX4GYI+GcPJFBr3eLw4iPwVoUHTevANVTu7Is5+0z2VZJDlp3peK38fLQ71Ig9G3CT867jQjr8JQdIjSuBcjUvjiiSLm75e65GgAOHFIO71ySwV+j/GkywY0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716964876; c=relaxed/simple;
	bh=d+t7VHAaoNZBDAHnp2Ge5uoRyOMdm+3p5SnU74SgzeE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n+mfoebZv2I9nxrz8t66/y8HqSLIz3LSkeAHfbYwScotRBf9r2D3o5iqGA9SKKDbrG1u3ZPo7UPDtM4Sx1WRHzrE5e8t6UBta1DyvzoZD85ELA0tvoU/a3XqiY+CmRBcBk6auXROCYuYN+sZ2XRiDPNFH9FelmwRPBPMgGAeAkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51D2AC2BD10;
	Wed, 29 May 2024 06:41:14 +0000 (UTC)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	ntfs3@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH 0/2] fs/ntfs3: Fix bugs and typos
Date: Wed, 29 May 2024 14:40:51 +0800
Message-ID: <20240529064053.2741996-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When we enable NTFS3 on Loongson platforms we found some bugs and
typos. So fix them.

Huacai Chen(2):
 fs/ntfs3: Update log->page_{mask,bits} if log->page_size changed.
 fs/ntfs3: Rename the label end_reply to end_replay.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
2.27.0


