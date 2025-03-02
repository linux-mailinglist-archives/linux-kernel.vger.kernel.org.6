Return-Path: <linux-kernel+bounces-540262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B840A4AF9E
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 07:51:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 606167A9D3A
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 06:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46C511F4625;
	Sun,  2 Mar 2025 06:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="OdCdW/sU"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762D61D6DBB
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 06:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740897869; cv=none; b=DKQa2SvsxM0XvCU8I1j0sICiXao6ExmouL508qXdUzwh3R7Pq/vxO1dcoitl3gJACeuAYNYnNnEzEsYnpKfptG4zCgQ7RijUCenn2yCvvAbS4cUEy/A6vi5Y3ukh0sfZ1bckRUIBxYAqoNiAdAz8zPVQox9imvyWEW2hbSdCuGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740897869; c=relaxed/simple;
	bh=ImIq5E+yzSMuk5VQu4015FnEeU4ZkIfZhZtOrHrX2Ew=;
	h=From:To:Cc:Subject:MIME-Version:Content-Type:Message-Id:Date; b=NOkolP/lr0FljrkY+AyZTAHbc52iqiAyyjo7H/1D4AVlzoo5UDCxG25nHBPhrJbi1vU/bQQ4YF/R+x9tibY+ZsPx1KIy3/WJPkT5pPzyZP1v7CCyXeArI/Hste3wZiA8AhBS6+nFZ4E4WwH3Iwa17cRMeT3juUDcK2v5MlHPcek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=OdCdW/sU; arc=none smtp.client-ip=220.197.31.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:MIME-Version:Content-Type:Message-Id:
	Date; bh=ImIq5E+yzSMuk5VQu4015FnEeU4ZkIfZhZtOrHrX2Ew=; b=OdCdW/s
	UishCxNqr+ajUFSMh4s+5dfaV+xCMRzRKf8uZJ983ZJckXZ3oCbx1gYTr7G6SAuv
	SEf6WWZmiXVgBD0uSGRcT4tVeJ77XrxNoyqEq7NCsj4V3UesBJVratIYtpd7PYD+
	xH2vkbgy7SKvWUXcVTKTW8ExuTgUTY3bLc20=
Received: from localhost (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PykvCgD3b2lG_sNnTSQJBg--.60099S2;
	Sun, 02 Mar 2025 14:44:23 +0800 (CST)
From: adam_smystery@126.com
To: linux-kernel@vger.kernel.org
Cc: 
Subject: Hello! Rust is better than Typescript
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-CM-TRANSID:PykvCgD3b2lG_sNnTSQJBg--.60099S2
Message-Id:<67C3FE47.0D9058.12474@m16.mail.126.com>
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUgjNKUUUUU
Date: Sun, 2 Mar 2025 14:44:23 +0800 (CST)
X-CM-SenderInfo: 5dgdzspvp123xhu1qiyswou0bp/1tbiOgkEumfD7Anz9gAAsJ

Hello! Rust is better than Typescript


