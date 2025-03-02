Return-Path: <linux-kernel+bounces-540343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53E96A4B002
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 08:10:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05253165E1C
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 07:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D95AA20C480;
	Sun,  2 Mar 2025 06:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="lfFxr8pT"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C0F1EB1AB
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 06:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740898740; cv=none; b=q6VAJLrpRjK773isroD20ue3xtp3ba3uemf5LY8bjer4XEFAkkXry9LlUUwQZNbvNNHsl5aJObVQlRugqciGZ053QOgnEsOe0UL04zTI4txnhA1zQZdC5OEKL+oNqvkTXJZSDX52dhmLriZ5Ui9xxXnslsA/hyPZcwVClm0nT8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740898740; c=relaxed/simple;
	bh=cftqaDB8AEPz09qm4a8a9qxUPytrv8Vr6D6ryPJtm4g=;
	h=From:To:Cc:Subject:MIME-Version:Content-Type:Message-Id:Date; b=pgoGq7vWT+q/5FEvpvoFNQd0t/GU6VXKAszrOzplFrJnN3nMV1A/frBHHlFBUJyWOne0jq85xbZwTJoki87Mu/h6CJYNyUSyZvB4PyNaD/pu8EABRhZNWs0QuKf3Nc1kX8ITRSoA793GZGs9AVoksq2jw6nZ/opePdwzV40QOHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=lfFxr8pT; arc=none smtp.client-ip=220.197.31.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:MIME-Version:Content-Type:Message-Id:
	Date; bh=cftqaDB8AEPz09qm4a8a9qxUPytrv8Vr6D6ryPJtm4g=; b=lfFxr8p
	Tygjr3Jd/aM1DTghU+Z76puqxAe9BKgKOS4vUMiSj95A44v48Ar3tzlqVS+5vOvf
	o/fKdFfcF61imdH32KoofDAmKJDjm5XWJE1xgtSveP0YcFJwSWH0trmJ/QrdaUx2
	ESE3SinMIaYm9YqcKAgujA/s4bHPn2PzN668=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wD393Yf_sNnjfaxBg--.21156S2;
	Sun, 02 Mar 2025 14:43:43 +0800 (CST)
From: adam_smystery@126.com
To: linux-kernel@vger.kernel.org
Cc: 
Subject: Hello! Rust is better than Java
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-CM-TRANSID:_____wD393Yf_sNnjfaxBg--.21156S2
Message-Id:<67C3FE1F.071812.00001@m16.mail.126.com>
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUTo7KDUUUU
Date: Sun, 2 Mar 2025 14:58:55 +0800 (CST)
X-CM-SenderInfo: 5dgdzspvp123xhu1qiyswou0bp/1tbiihkEumfD7fHXaAAAsq

Hello! Rust is better than Java


