Return-Path: <linux-kernel+bounces-559913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B6172A5FADF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 17:11:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0AC47A4EA6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 16:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C2BA26BD8C;
	Thu, 13 Mar 2025 16:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="OdoSv+Fs"
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A4E26BD83
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 16:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741881848; cv=none; b=uxtTonXSOK07QsnEXaZOTbvg+5vcLYjwHh6BovBnqSDhj0FyN5bHIjQXq3X+jC0VYTCmoLbJhoV+wLV84/XXhKcY3Gpu3mSW9XHX6C0sAUgK/EUJNmQWNWG1JVBAQs+BT6g2bJ3hzSioc+W/vf5vp15IoA8m3CByKLNGlE4ESOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741881848; c=relaxed/simple;
	bh=hBSfzFoCyQ5JKu6HvTphQSCiNduazkjE8VhN+ka+iv4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UsnMnor2V6JKmffq9Oemj17Z2ZBl0y8nYy+R3MWkKKqRjV9RRUfLfcA1iqsiVy2yaPW1298nIQcQIa5wNh4YzgRHtDWtIZPJ4YF2xiTncbknD1+FIgHU6CLNePJw2DcXypb/MoOXLtlRSQsW6/xBKdiQXWAg6Sip3dZtgRnf3hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=OdoSv+Fs; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1741881845; x=1742141045;
	bh=zJzfYxqTGkpvxERVV5xc7MvB+YJR4f+zoVmRta1ZEMc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=OdoSv+FsaUzHNvgKe8WkVvrVYmpgRJUbIw/9WlM2oG8d+T+VpA/us+gkkYvVptNnO
	 mTJ+gkIiQ3QRtGFb1QmFTYp8i+fO1czeq8VB6YSt944F1ItXw5bvdpluoNL5ZkHB88
	 /Q9AyULSgoc6oi3OH0LvxzFn8GnjYAO26b6WrRTed2iw20yIK+Be+p3XABQY3nsHjR
	 4nqzW9a2V11V+ewo5fw3Ay2tRam5qC/URzDixgkJhyxmwtiTNwxwfIquqOE8EzjWzr
	 bjTYn/vPG+LZX8PP+WXYnVJcFmYyuD2t+NKHZBeluSH2rwljPBaDhmVIbXvN5rhBqO
	 w6TQEEPDBvW6w==
Date: Thu, 13 Mar 2025 16:04:00 +0000
To: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-input@vger.kernel.org, dri-devel@lists.freedesktop.org
From: Rahul Rameshbabu <sergeantsagara@protonmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Rahul Rameshbabu <sergeantsagara@protonmail.com>
Subject: [PATCH RFC 3/3] rust: hid: demo the core abstractions for probe and remove
Message-ID: <20250313160220.6410-6-sergeantsagara@protonmail.com>
In-Reply-To: <20250313160220.6410-2-sergeantsagara@protonmail.com>
References: <20250313160220.6410-2-sergeantsagara@protonmail.com>
Feedback-ID: 26003777:user:proton
X-Pm-Message-ID: b638180c65cc3d8ba015ced71bcec205a97bd6d0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This is a very basic "hello, world!" implementation to illustrate that the
probe and remove callbacks are working as expected. I chose an arbitrary
device I had on hand for populating in the HID device id table.

  [  +0.012968] monitor_control: Probing HID device vendor: 2389 product: 2=
9204 using Rust!
  [  +0.000108] monitor_control: Removing HID device vendor: 2389 product: =
29204 using Rust!

Signed-off-by: Rahul Rameshbabu <sergeantsagara@protonmail.com>
---
 drivers/hid/hid_monitor_control.rs | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid_monitor_control.rs b/drivers/hid/hid_monitor_c=
ontrol.rs
index 18afd69a56d5..aeb6e4058a6b 100644
--- a/drivers/hid/hid_monitor_control.rs
+++ b/drivers/hid/hid_monitor_control.rs
@@ -8,17 +8,22 @@
     Driver,
 };
=20
+const USB_VENDOR_ID_NVIDIA: u32 =3D 0x0955;
+const USB_DEVICE_ID_NVIDIA_THUNDERSTRIKE_CONTROLLER: u32 =3D 0x7214;
+
 struct HidMonitorControl;
=20
 #[vtable]
 impl Driver for HidMonitorControl {
     fn probe(dev: &mut hid::Device, id: &hid::DeviceId) -> Result<()> {
         /* TODO implement */
+        pr_info!("Probing HID device vendor: {} product: {} using Rust!\n"=
, id.vendor(), id.product());
         Ok(())
     }
=20
     fn remove(dev: &mut hid::Device) {
         /* TODO implement */
+        pr_info!("Removing HID device vendor: {} product: {} using Rust!\n=
", dev.vendor(), dev.product());
     }
 }
=20
@@ -26,8 +31,8 @@ fn remove(dev: &mut hid::Device) {
     driver: HidMonitorControl,
     id_table: [
         kernel::usb_device! {
-            vendor: /* TODO fill in */,
-            product: /* TODO fill in */,
+            vendor: USB_VENDOR_ID_NVIDIA,
+            product: USB_DEVICE_ID_NVIDIA_THUNDERSTRIKE_CONTROLLER,
         },
     ],
     name: "monitor_control",
--=20
2.47.2



